package com.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.ComplaintDTO;

@Repository
public class ComplaintDAO {
	@Autowired
	SqlSessionTemplate template;
	
	public int insertComplaint(ComplaintDTO dto) {
		return template.insert("ComplaintMapper.insertComplaint",dto);
	}

	public ComplaintDTO checkDuplication(ComplaintDTO dto) {
		return template.selectOne("ComplaintMapper.checkDuplication",dto);
	}
	
}
