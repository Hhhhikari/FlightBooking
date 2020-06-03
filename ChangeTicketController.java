package com.web;

import java.sql.Date;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bean.Ordered;
import com.bean.Rule;
import com.bean.Ticket;
import com.dao.ChangeMapper;
import com.dao.myMapper;

@Controller
public class ChangeTicketController {
	@Autowired
	private ChangeMapper change;
	@Autowired 
	MyOrderList myOrderList;
	@RequestMapping(value = "change")
	public ModelAndView ChangeTicket(HttpServletRequest request, HttpServletResponse response) {
		String passport = null;
		String tripID = null;
		Cookie[] cookie = request.getCookies();
		for (Cookie c : cookie) {
			if (c.getName().equals("passport")) {
				passport = c.getValue();
			}
			if (c.getName().equals("trip_id")) {
				tripID = c.getValue();
			}
		}
		Ticket t = new Ticket();
		Ordered o = new Ordered();
		t.setPassport(passport);
		t.setTripID(tripID);
		List<Ticket> tiks = change.findTicket(t);
		List<Ordered> ords = new ArrayList<>();
		for (int i = 0; i < tiks.size(); i++) {
			o.setFlightID(tiks.get(i).getFlightID());
			o.setSeatID(tiks.get(i).getSeatID());
			o.setDate(tiks.get(i).getDate());
			ords.add(o);
		}
		double rate = 0;
		String dt = change.findDepatureTime(tiks.get(0));
		String[] time = dt.split("\\�?);
		Calendar cal = Calendar.getInstance();
		int h = cal.get(Calendar.HOUR_OF_DAY);
		int m = cal.get(Calendar.MINUTE);
		int systime = h * 60 + m;
		int tktime = Integer.parseInt(time[0]) * 60 + Integer.parseInt(time[1]);
		int ptime = systime -tktime;
		if (ptime > 0 && ptime <= 120) {
			rate = 0.1;
		} else if (ptime > 120) {
			rate = 0.2;
		}
		String datedefine = String.valueOf(change.findDate(tiks.get(0)));
		String fromcitydefine = change.findFromCity(tiks.get(0));
		String tocitydefine = null;
		Cookie state = new Cookie("tag_change", "可执�?);
		double addfare = 0;
		double totalfare=0;
		if (tiks.size() == 1) {
			tocitydefine = change.findToCity(tiks.get(0));
			addfare = (1-rate) * (tiks.get(0).getFare());
			totalfare=tiks.get(0).getFare();
		} else {
			tocitydefine =change.findToCity(tiks.get(1));
			addfare = (1-rate) * (tiks.get(0).getFare() + tiks.get(1).getFare());
			totalfare=tiks.get(0).getFare() + tiks.get(1).getFare();
		}
		int flag = isTimeRebook(passport, tripID);
		Rule rule=new Rule();
		Cookie tag2 = null;
		Cookie fare=new Cookie("addfare", "0");
		if (flag == 0) {
			rule.setFromCity(fromcitydefine);
			rule.setToCity(tocitydefine);
			rule.setPeopleNum(1);
			fare.setValue(String.valueOf(addfare));
			tag2=new Cookie("tag2", "0");
		} else if (flag == -1) {
			state.setValue("0");
		} else if(flag==1) {
			rule.setFromCity(fromcitydefine);
			rule.setToCity(tocitydefine);
			rule.setPeopleNum(1);
			fare.setValue(String.valueOf(totalfare));
			tag2=new Cookie("tag2", "1");
		}
		response.addCookie(state);
		response.addCookie(fare);
		response.addCookie(tag2);
		if (flag == -1) {
			return myOrderList.searchOrder(request, response);
		} else if (flag == 0) {
			for (int i = 0; i < tiks.size(); i++) {
				change.deleteOrdered(ords.get(i));
				change.deleteTicket(tiks.get(i));
			}
			rule.setDate(datedefine);
			ModelAndView mView=new ModelAndView("homePage");
			mView.addObject("rule", rule);
			return mView;// 锁定日期
		} else {
			for (int i = 0; i < tiks.size(); i++) {
				change.deleteOrdered(ords.get(i));
				change.deleteTicket(tiks.get(i));
			}
			ModelAndView mView=new ModelAndView("homePage");
			mView.addObject("rule", rule);
			return mView;// 未锁�?
		}
	}

	public int isTimeRebook(String passport, String tripID) {
		int isOK = 1;// 1 表示可改签任意日�?0 表示只能改签车票当日 -1 表示不可改签
		Ticket t = new Ticket();
		t.setPassport(passport);
		t.setTripID(tripID);
		List<Ticket> tiks = change.findTicket(t);
		java.util.Date getd = new java.util.Date(change.findDate(tiks.get(0)).getTime());
		String gett = change.findDepatureTime(tiks.get(0));
		Calendar date = Calendar.getInstance();
		date.setTime(getd);
		String[] time = gett.split("\\�?);
		Calendar cal = Calendar.getInstance();
		long millcal = cal.getTimeInMillis();
		long milldate = date.getTimeInMillis();
		int h = cal.get(Calendar.HOUR_OF_DAY);
		int min = cal.get(Calendar.MINUTE);
		int systime = h * 60 + min;
		int tktime = Integer.parseInt(time[0]) * 60 + Integer.parseInt(time[1]);
		int ptime = systime - tktime;
		int milltime = Integer.parseInt(String.valueOf(millcal - milldate));
		if (milltime < 0) {
			isOK = 1;
		} else if (milltime > 0 && milltime < 86400000) {
			if (ptime <= 0) {// 可随意改�?
				isOK = 1;
			} else if (ptime > 0) {// 可改签当�?
				isOK = 0;
			}
		} else if (milltime > 86400000) {// 不可改签
			isOK = -1;
			for (Ticket tik : tiks) {
				change.updateState(tik);
			}
		}
		return isOK;
	}
}
