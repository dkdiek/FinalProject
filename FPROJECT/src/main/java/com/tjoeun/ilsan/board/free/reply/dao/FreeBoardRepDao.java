package com.tjoeun.ilsan.board.free.reply.dao;

import java.util.List;
import java.util.Map;

public interface FreeBoardRepDao {
	
	public int insert(Map map);

	public List<Map> select(Map map);

}
