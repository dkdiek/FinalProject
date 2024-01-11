package com.tjoeun.ilsan.member.service;

import java.util.Map;

public interface MemberService {
	
    public boolean checkLogin(String id, String password);
	public int joinMembership(Map map) throws Exception;
	public Map checkDuplication(Map map);
	public Map getMemberInfoById(Map map);
	public int updateMemberInfo(Map map);
}
