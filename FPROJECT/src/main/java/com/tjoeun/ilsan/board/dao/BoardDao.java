package com.tjoeun.ilsan.board.dao;

import java.util.List;
import java.util.Map;

public interface BoardDao {
	
	public int uploadBoard(Map map);
	public Map selectBoardDetail(Map map);
	public List selectBoardList(Map map);
	public List<Map> searchBoardList(Map map);
    public int selectBoardCount(Map map);
}
