package com.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.SanctionDTO;


@Repository
public class SanctionDAO {
	@Autowired
	SqlSessionTemplate template;

	public int insertSanction(SanctionDTO saDTO) {
		return template.insert("SanctionMapper.insertSanction",saDTO);
	}
}
