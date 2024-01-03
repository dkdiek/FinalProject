package com.tjoeun.ilsan.board.sql;

import java.util.Map;

public interface BoardMapper {
	
	public int uploadBoard(Map map);
	public Map selectBoard(Map map);
}
