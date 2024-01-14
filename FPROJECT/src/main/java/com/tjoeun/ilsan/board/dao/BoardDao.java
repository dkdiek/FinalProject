package com.tjoeun.ilsan.board.dao;

import java.util.List;
import java.util.Map;

public interface BoardDao {
	
	public int uploadBoard(Map map);
	public Map selectBoardDetail(Map map);
	public List selectBoardList(Map map);
	public List<Map> searchBoardList(Map map);
    public int selectBoardCount(Map map);
    public int increaseViewCount(int seq);
    public int checkLikeStatus(Map map);
    public int addLike(Map map);
    public int cancelLike(Map map);
    public List<Map> selectLikeList(Map map);

    public int soldout(int seq);
    public int deleteBoard(Map map);
	public int updateBoard(Map map);
	
	
	
	public List<Map> searchFilterList(Map map);
    public int searchFilterListCount(Map map);
    public List<Map> selectBoardsWithInterest(Map map);


}
