package com.tjoeun.ilsan.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 작성페이지
	@PostMapping("/writeView")
	public String writeView() {
	    // id를 사용하여 필요한 작업 수행
	    return "sales/writeView";
	}
	
	// 작성
	@PostMapping("/writeProcess")
	public String writeProcess(Map map, @RequestParam(value = "images") List<MultipartFile> mFiles, HttpSession httpSession) {
		try {
			boardService.upload(map, mFiles, httpSession);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
}
