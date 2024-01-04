package com.tjoeun.ilsan.board.sql;

import java.util.List;
import java.util.Map;

public interface BoardMapper {
	
	public int uploadBoard(Map map);
	public Map selectBoard(Map map);
	public List selectBoardList(Map map);
    // �Խñ� �˻� ��ȸ (����¡ ó�� ����)
	public List<Map> searchBoardList(Map map);
    // �Խñ� �� ���ڵ� �� ��ȸ
    public int selectBoardCount(Map map);
}
