package com.tjoeun.ilsan.member.sql;

import java.util.Map;

public interface MemberMapper {
	
    public Map checkLogin(Map map);
    public int joinMembership(Map map);
    
}
