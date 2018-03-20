package com.syyf.movieMgr.dao;

import java.util.List;
import java.util.Map;

public interface TicketMapper {

	List<Map<String,String>> query(String ticket_code);

}