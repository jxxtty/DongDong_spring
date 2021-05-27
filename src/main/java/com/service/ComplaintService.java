package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ComplaintDAO;
import com.dto.ComplaintDTO;

@Service
public class ComplaintService {
	@Autowired
	ComplaintDAO coDAO;
	
	public int insertComplaint(ComplaintDTO dto) {
		 return coDAO.insertComplaint(dto);
	}
	
	public boolean checkDuplication(ComplaintDTO dto) {
	    if(coDAO.checkDuplication(dto)!=null) { 	
	    	return true;	
	    } else {
	    	return false;
	    }
	}
	
	public List<ComplaintDTO> postComplaintList() {
	    return coDAO.postComplaintList();
	}
	public List<ComplaintDTO> memberComplaintList() {
		return coDAO.memberComplaintList();
	}
	public List<ComplaintDTO> commentComplaintList() {
		return coDAO.commentComplaintList();
	}
}
