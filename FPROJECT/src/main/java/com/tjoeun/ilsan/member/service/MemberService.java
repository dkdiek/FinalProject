package com.tjoeun.ilsan.member.service;

import java.util.Map;

public interface MemberService {
	
    public boolean checkLogin(String id, String password);
	public int joinMembership(Map map) throws Exception;
	public Map checkDuplication(Map map);
	public Map getMemberInfoById(String member_id);
}
