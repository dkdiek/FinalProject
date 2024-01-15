package com.tjoeun.ilsan.member.service;

import java.util.Map;

public interface MemberService {
	
    public boolean checkLogin(String id, String password);
    public Map checkSocialMember(Map map);
	public int joinMembership(Map map) throws Exception;
	public Map checkDuplication(Map map);
	public Map getMemberInfoById(Map map);
	public int updateMemberInfo(Map map);
    public Map findAccount(Map map);


}
