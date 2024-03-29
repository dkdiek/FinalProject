package com.tjoeun.ilsan.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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

	        // �� �κп����� Map�� ��ȯ���� �ʰ�, ���� ���ο� ���� true �Ǵ� false�� ��ȯ�մϴ�.
	        return memberDao.checkLogin(params) != null;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	@Override
	public Map checkSocialMember(Map map) {
        return memberDao.checkSocialMember(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int joinMembership(Map map) throws Exception {
		int result = memberDao.joinMembership(map);
		if( 1 != result) {
			throw new Exception();
		} else {
			return result;
		}
	}

	@Override
	@Transactional
	public Map checkDuplication(Map map) {
        return memberDao.checkDuplication(map);
	}

	@Override
	@Transactional
	public Map getMemberInfoById(Map map) {
        return memberDao.getMemberInfoById(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int updateMemberInfo(Map map) {
		return memberDao.updateMemberInfo(map);
	}

	@Override
	public Map findAccount(Map map) {
		return memberDao.findAccount(map);
	}
}
