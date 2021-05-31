package com.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.SanctionDAO;
import com.dto.SanctionDTO;


@Service
public class SanctionService {
	@Autowired
	SanctionDAO saDAO;

	public int insertSanction(SanctionDTO saDTO) {
		return saDAO.insertSanction(saDTO);
	}

	public List<SanctionDTO> sanctionList(String userid) {
		return saDAO.sanctionList(userid);
	}
	
	public String getEndDateByUserid(String userid) {
		return saDAO.getEndDateByUserid(userid);
	}
	
	public boolean isSanctioned(String userid) {
		return saDAO.isSanctioned(userid);
	}
}
