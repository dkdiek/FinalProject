package com.tjoeun.ilsan.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
	public ResponseEntity<?> login(@RequestParam String id, @RequestParam String password, HttpSession session) {
	    boolean loginResult = memberService.checkLogin(id, password);

	    if (loginResult) {
	        // 로그인 성공
	        session.setAttribute("id", id);
	        return ResponseEntity.ok().body("로그인에 성공했습니다.");  // 성공 메시지를 담은 응답
	    } else {
	        // 로그인 실패
	        return ResponseEntity.status(401).body("아이디 또는 비밀번호가 잘못되었습니다.");  // 실패 메시지를 담은 응답
	    }
	}
	
	@RequestMapping(value="member/join/joinMember", method = RequestMethod.GET)
	public String joinMember( ) {
		return "member/join/joinMember";
	}
	
	@RequestMapping(value="member/join/joinMember2", method = RequestMethod.GET)
	public String joinMember2( ) {
		return "member/join/joinMember2";
	}

	
}
