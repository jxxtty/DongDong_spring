package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ComplaintDAO;
import com.dto.ComplaintDTO;

@Service
public class ComplaintService {
	@Autowired
	ComplaintDAO dao;
	public int insertComplaint(ComplaintDTO dto) {
		 return dao.insertComplaint(dto);
	}
	
	public boolean checkDuplication(ComplaintDTO dto) {
	    if(dao.checkDuplication(dto)!=null) { 	
	    	return true;	
	    } else {
	    	return false;
	    }
	}
}
