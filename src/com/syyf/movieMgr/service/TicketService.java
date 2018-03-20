package com.syyf.movieMgr.service;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.syyf.movieMgr.dao.TicketMapper;

@Service
@Transactional
public class TicketService {

	@Resource
	private TicketMapper ticketMapper;


	@Transactional(readOnly=true)
	public String queryTicket(String ticket_code) {
		return JSON.toJSONString(ticketMapper.query(ticket_code));
	}
}