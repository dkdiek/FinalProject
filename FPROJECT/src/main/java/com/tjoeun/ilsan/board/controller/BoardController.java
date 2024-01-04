package com.tjoeun.ilsan.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	// 작성페이지
	@GetMapping("/writeView")
	public String writeView(HttpSession session) {
		return "/sales/writeView";
	}
	
	// 작성
	@PostMapping("/writeProcess")
	public String writeProcess(@RequestParam Map map, @RequestParam(value = "images") List<MultipartFile> mFiles, HttpSession httpSession) {
		int seq = 0;
		try {
			seq = boardService.upload(map, mFiles, httpSession);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/detail?seq=" + seq;
	}
	
	// 디테일 뷰
	@GetMapping("/detail")
	public String showDetail(@RequestParam("seq") int seq, Model model) {
		Map map = new HashMap();
	    map.put("seq", seq);
	    Map boardDetail = boardService.selectBoardDetail(map);
	    
	    model.addAttribute("boardDetail", boardDetail);
	    model.addAttribute("imgList", boardDetail.get("imgList"));

	    return "sales/detailView"; // detail.jsp로 포워딩
	}
	
	@GetMapping("/search")
	public String showSearch(@RequestParam Map map, Model model) {
	    // limit와 offset을 사용하여 페이징 처리 등을 수행

	    // 검색 결과 가져오기
	    List<Map> boardList = boardService.searchBoardList(map);

	    // 페이징 정보 가져오기
	    int boardCount = boardService.selectBoardCount(map);

	    model.addAttribute("boardList", boardList);
	    model.addAttribute("boardCount", boardCount);

	    return "sales/searchView";
	}
	
	
	
}
