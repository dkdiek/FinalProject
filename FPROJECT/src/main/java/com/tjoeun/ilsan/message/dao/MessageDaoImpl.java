package com.tjoeun.ilsan.message.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.member.sql.MemberMapper;
import com.tjoeun.ilsan.message.sql.MessageMapper;

@Repository
public class MessageDaoImpl implements MessageDao{
	
	@Autowired
	SqlSession sqlSession;


	@Override
	public int sendMessage(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.sendMessage(map) ;
	}


	@Override
	public List<Map> selectMessageList(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.selectMessageList(map) ;
	}


	@Override
	public int selectMessageListCnt(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.selectMessageListCnt(map) ;
	}
	
	@Override
	public int deleteShowToId(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.deleteShowToId(map) ;
	}
	
	@Override
	public List<Map> selectMessageList2(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.selectMessageList2(map) ;
	}
	
	
	@Override
	public int selectMessageListCnt2(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.selectMessageListCnt2(map) ;
	}
	
	@Override
	public int deleteShowFromId(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.deleteShowFromId(map) ;
	}

	@Override
	public int updateMessageRead(Map map) {
		MessageMapper mapper = sqlSession.getMapper(MessageMapper.class);
		return mapper.updateMessageRead(map) ;
	}



}
