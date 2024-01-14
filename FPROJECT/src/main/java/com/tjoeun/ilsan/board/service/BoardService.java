package com.tjoeun.ilsan.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public int upload(Map map, List<MultipartFile> mFiles, HttpSession httpSession) throws Exception;
	public Map selectBoardDetail(Map map);
	public List selectBoardList(Map map);
	public List<Map> searchBoardList(Map map);
    public int selectBoardCount(Map map);
    public int increaseViewCount(int seq);
    public int checkLikeStatus(Map map);
    public ResponseEntity<String> processLike(Map map);
    public ResponseEntity<String> soldout(int seq);
    public ResponseEntity<String> deleteBoard(Map map);
	public int updateBoard(Map map) throws Exception;
    public int deleteLike(Map map);
    public List<Map> selectLikeList(Map map);

    
	public List<Map> searchFilterList(Map map);
	public int searchFilterListCount(Map map);
    public List<Map> selectBoardsWithInterest(Map map);


}
