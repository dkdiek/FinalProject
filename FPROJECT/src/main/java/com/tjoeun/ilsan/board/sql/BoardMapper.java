package com.tjoeun.ilsan.board.sql;

import java.util.List;
import java.util.Map;

public interface BoardMapper {
	
	public int uploadBoard(Map map);
	public Map selectBoard(Map map);
	public List selectBoardList(Map map);
    // 게시글 검색 조회 (페이징 처리 포함)
	public List<Map> searchBoardList(Map map);
    // 게시글 총 레코드 수 조회
    public int selectBoardCount(Map map);
}
