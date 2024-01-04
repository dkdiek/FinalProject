package com.tjoeun.ilsan.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	// 로그인
	@PostMapping("/login")
	@ResponseBody
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password, HttpSession session) {
	    boolean loginResult = memberService.checkLogin(id, password);

	    if (loginResult) {
	        session.setAttribute("id", id);
	        return ResponseEntity.ok("{\"message\": \"success\"}");
	    } else {
	        return ResponseEntity.status(401).body("{\"message\": \"fail\"}");
	    }
	}
	
	//http://localhost/naverLogin
	//azdDptdhj5zpBKzKMGuq
	//Irj41To1KM
	
	// 로그아웃
	@GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션에서 사용자 정보 제거
        session.removeAttribute("id");
        session.invalidate();
        return "redirect:/";
    }
	
	// 회원가입 1단계 - 약관
	@GetMapping("/joinMembership")
	public String joinMember( ) {
		return "member/join/joinMember";
	}
	
	// 회원가입 2단계 - 정보 입력
	@GetMapping("/joinMembership2")
	public String joinMember2( ) {
		return "member/join/joinMember2";
	}
	
	// 회원 가입 처리
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
