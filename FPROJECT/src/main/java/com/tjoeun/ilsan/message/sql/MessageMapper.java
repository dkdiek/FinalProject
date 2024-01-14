package com.tjoeun.ilsan.message.sql;

import java.util.List;
import java.util.Map;

public interface MessageMapper {
	
    public int sendMessage(Map map);
	public List<Map> selectMessageList(Map map);
	public int selectMessageListCnt(Map map);
	public List<Map> selectMessageList2(Map map);
	public int selectMessageListCnt2(Map map);
	public int updateMessageRead(Map map);

}
