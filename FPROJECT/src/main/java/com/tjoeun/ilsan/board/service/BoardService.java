package com.tjoeun.ilsan.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public void upload(Map map, List<MultipartFile> mFiles, HttpSession httpSession) throws Exception;


}
