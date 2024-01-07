package com.tjoeun.ilsan.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password, @RequestParam(name = "returnUrl", required = false) String returnUrl, HttpSession session) {
	    boolean loginResult = memberService.checkLogin(id, password);

	    if (loginResult) {
	        session.setAttribute("id", id);
	        String redirectUrl = (returnUrl != null && !returnUrl.isEmpty()) ? returnUrl : "/";
	        String checkLoginSession = (String)session.getAttribute("id");
	        System.out.println("로그인 체크" + checkLoginSession);
	        // JSON 형태로 응답
	        return ResponseEntity.ok("{\"message\": \"success\", \"returnUrl\": \"" + redirectUrl + "\"}");
	    } else {
	        return ResponseEntity.status(401).body("{\"message\": \"fail\"}");
	    }
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, @RequestParam(name = "returnUrl", required = false) String returnUrl) {
	    // 세션에서 사용자 정보 제거
	    if (session.getAttribute("id") != null) {
	        session.removeAttribute("id");
	    }
	    // 세션을 무효화
	    session.invalidate();
	    // returnUrl이 제공된 경우 해당 페이지로 리다이렉트, 그렇지 않은 경우 기본 리다이렉트 설정
	    return "redirect:" + (returnUrl != null ? returnUrl : "/");
	}


	
	//네이버 로그인 http://localhost/naverLogin
	//azdDptdhj5zpBKzKMGuq
	//Irj41To1KM

	
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
	
	// ID, email, phone 중복 검사
	@PostMapping("/checkDuplication")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> checkId(@RequestParam Map<String, String> map) {
	    try {
	        Map<String, Object> result = memberService.checkDuplication(map);
	        Map<String, Object> response = new HashMap<>();

	        // 여기서 result를 적절히 가공 또는 확인한 후 클라이언트에 응답을 보낼 수 있습니다.
	        if (result != null) {
	        	response.put("message", "사용 불가");
	            return new ResponseEntity<>(response, HttpStatus.OK);
	        } else {
	            // 중복이 없을 때의 처리
	            response.put("message", "사용 가능");
	            return new ResponseEntity<>(response, HttpStatus.OK);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 예외가 발생했을 경우에 대한 처리
	        Map<String, Object> response = new HashMap<>();
	        response.put("message", "서버 오류가 발생했습니다.");
	        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	// 회원 가입 처리
	@PostMapping("/joinProcess")
	public String joinProcess (@RequestParam Map map, Model model) {
		try {
	        memberService.joinMembership(map);
	        // 리다이렉션을 사용하여 "/joinResult"로 이동
	        return "redirect:/joinResult?result=1";
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 리다이렉션을 사용하여 "/joinResult"로 이동
	        return "redirect:/joinResult?result=0";
	    }
	}
	
	// 회원 가입 결과 페이지
	@GetMapping("/joinResult")
	public String joinResult(@RequestParam(name = "result", defaultValue = "0") int result, Model model) {
	    model.addAttribute("result", result);
	    return "member/join/joinResult";
	}

	
}
