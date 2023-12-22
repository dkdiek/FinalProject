package com.tjoeun.ilsan.common.file.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.common.file.sql.CommonFileMapper;

@Repository
public class CommonFileDaoImpl implements CommonFileDao {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insert(Map map) {
		CommonFileMapper mapper = sqlSession.getMapper(CommonFileMapper.class);
		return mapper.insert(map);
	}

	@Override
	public List<Map> select(Map map) {
		CommonFileMapper mapper = sqlSession.getMapper(CommonFileMapper.class);
		return mapper.select(map);
	}
	

}
