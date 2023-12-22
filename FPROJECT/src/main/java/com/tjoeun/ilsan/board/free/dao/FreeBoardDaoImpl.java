package com.tjoeun.ilsan.board.free.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.board.free.sql.FreeBoardMapper;

@Repository
public class FreeBoardDaoImpl implements FreeBoardDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Map selectTotalCnt(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.selectTotalCnt(map);
	}

	@Override
	public List<Map> select(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.select(map);
	}

	@Override
	public int write(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.write(map);
	}

	@Override
	public int delete(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.delete(map);
	}

	@Override
	public int update(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.update(map);
	}

	@Override
	public int updateRec(Map map) {
		FreeBoardMapper mapper = sqlSession.getMapper(FreeBoardMapper.class);
		return mapper.updateRec(map);
	}


}
