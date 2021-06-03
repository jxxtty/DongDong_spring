package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AlarmDAO;
import com.dto.Alarm;


@Service
public class AlarmService {
	
	@Autowired
	AlarmDAO dao;

	public void newAlarm(Alarm alarm) {
		
	}
	
	
}
