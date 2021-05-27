package com.service;


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
}
