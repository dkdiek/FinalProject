package com.tjoeun.ilsan.board.free.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.tjoeun.ilsan.board.free.reply.dao.FreeBoardRepDao;

@Service
@EnableTransactionManagement
public class FreeBoardRepServiceImpl implements FreeBoardRepService {

	
	@Autowired
	FreeBoardRepDao freeBoardRepDao;
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public void insert(Map map) throws Exception {
		int count = freeBoardRepDao.insert(map);
		if(1 != count) {
			throw new Exception();
		}
	}

	@Override
	@Transactional(readOnly = true)
	public List<Map> select(Map map) {
		return freeBoardRepDao.select(map);
	}


}
