package com.tjoeun.ilsan.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public int upload(Map map, List<MultipartFile> mFiles, HttpSession httpSession) throws Exception;
	public Map selectBoardDetail(Map map);
	public List selectBoardList(Map map);
	public List<Map> searchBoardList(Map map);
    public int selectBoardCount(Map map);

}
