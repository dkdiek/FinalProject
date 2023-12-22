package com.tjoeun.ilsan.board.free.reply.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.board.free.sql.FreeBoardRepMapper;

@Repository
public class FreeBoardRepDaoImpl implements FreeBoardRepDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insert(Map map) {
		FreeBoardRepMapper mapper = sqlSession.getMapper(FreeBoardRepMapper.class);
		return mapper.insert(map);
	}

	@Override
	public List<Map> select(Map map) {
		FreeBoardRepMapper mapper = sqlSession.getMapper(FreeBoardRepMapper.class);
		return mapper.select(map);
	}

}
