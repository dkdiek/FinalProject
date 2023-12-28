package com.tjoeun.ilsan.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.member.sql.MemberMapper;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Map checkLogin(Map params) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.checkLogin(params);
	}

}
