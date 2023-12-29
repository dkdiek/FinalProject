package com.tjoeun.ilsan.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	// 로그인
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password, HttpSession session) {
	    boolean loginResult = memberService.checkLogin(id, password);

	    if (loginResult) {
	        session.setAttribute("id", id);
	        return ResponseEntity.ok("{\"message\": \"로그인 성공\"}");
	    } else {
	        return ResponseEntity.status(401).body("{\"message\": \"로그인 실패\"}");
	    }
	}
	
	// 회원가입 1단계
	@RequestMapping(value="/joinMembership", method = RequestMethod.GET)
	public String joinMember( ) {
		return "member/join/joinMember";
	}
	
	// 회원가입 2단계
	@RequestMapping(value="/joinMembership2", method = RequestMethod.GET)
	public String joinMember2( ) {
		return "member/join/joinMember2";
	}
	
	// 회원가입 처리
	@PostMapping("/joinProcess")
	public String joinProcess (@RequestParam Map map, Model model) {
		try {
			memberService.joinMembership(map);
			model.addAttribute("result","1");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("result","0");
		}
		return "member/join/joinResult";
	}
	

	
}
