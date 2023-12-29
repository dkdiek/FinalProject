package com.tjoeun.ilsan.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.tjoeun.ilsan.member.dao.MemberDao;

@Service
@EnableTransactionManagement

public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao memberDao;

	@Override
	public boolean checkLogin(String id, String password) {
	    try {
	        Map<String, Object> params = new HashMap<>();
	        params.put("id", id);
	        params.put("password", password);

	        // 이 부분에서는 Map을 반환하지 않고, 성공 여부에 따라 true 또는 false를 반환합니다.
	        return memberDao.checkLogin(params) != null;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	public int joinMembership(Map map) throws Exception {
		int result = memberDao.joinMembership(map);
		if( 1 != result) {
			throw new Exception();
		} else {
			return result;
		}
	}

}
