package com.tjoeun.ilsan.member.dao;

import java.util.Map;

public interface MemberDao {
	
    public Map checkLogin(Map map);
    public int joinMembership(Map map);
    public Map checkDuplication(Map map);
	public Map getMemberInfoById(String member_id);

}
