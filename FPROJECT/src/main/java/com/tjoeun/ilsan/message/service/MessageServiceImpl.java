package com.tjoeun.ilsan.message.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.tjoeun.ilsan.message.dao.MessageDao;

@Service
@EnableTransactionManagement

public class MessageServiceImpl implements MessageService {
	
	@Autowired
	MessageDao messageDao;


	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int sendMessage(Map map) {
		return  messageDao.sendMessage(map);
	}


	@Override
	public List<Map> selectMessageList(Map map) {
		return  messageDao.selectMessageList(map);
	}


	@Override
	public int selectMessageListCnt(Map map) {
		return  messageDao.selectMessageListCnt(map);

	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int deleteShowToId(Map map) {
		return  messageDao.deleteShowToId(map);
	}
	
	@Override
	public List<Map> selectMessageList2(Map map) {
		return  messageDao.selectMessageList2(map);
	}
	
	
	@Override
	public int selectMessageListCnt2(Map map) {
		return  messageDao.selectMessageListCnt2(map);
		
	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int deleteShowFromId(Map map) {
		return  messageDao.deleteShowFromId(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int updateMessageRead(Map map) {
		return  messageDao.updateMessageRead(map);

	}


}
