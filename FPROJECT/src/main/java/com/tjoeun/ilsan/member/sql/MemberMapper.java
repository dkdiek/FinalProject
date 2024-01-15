package com.tjoeun.ilsan.member.sql;

import java.util.Map;

public interface MemberMapper {
	
    public Map checkLogin(Map map);
    public Map checkSocialMember(Map map);
    public int joinMembership(Map map);
    public Map checkDuplication(Map map);
	public Map getMemberInfoById(Map map);
	public int updateMemberInfo(Map map);
    public Map findAccount(Map map);
}
