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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.ilsan.board.service.BoardService;
import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	BoardService boardService;
	
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
	
	// 회원 가입 결과 페이지-------------------------------------------------------------------------------------
	@GetMapping("/joinResult")
	public String joinResult(@RequestParam(name = "result", defaultValue = "0") int result, Model model) {
	    model.addAttribute("result", result);
	    return "member/join/joinResult";
	}
	
	// 회원 정보 변경 1 ------------------------------------------------------------------------------------------
	@GetMapping("/updateMemberInfo")
	public String updateMemberInfo(HttpSession Session, Model model) {
		String result="";
		String id = (String)Session.getAttribute("id");
		
		if(id != null && !id.isEmpty()) {
			result= "/member/personal/updateMemberInfo1";
		} else {
			result="/common/errorPage";
			model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
		}
		return result;
	}
	
	// 회원 정보 변경 2 - 비밀번호 재확인-------------------------------------------------------------------------------------
	@PostMapping("/checkMemberAccount")
	public ResponseEntity<Map<String, Object>> checkMemberAccount(
	        @RequestBody Map map,
	        HttpSession session) {

	    String member_id_client = (String) map.get("member_id"); // 클라이언트에서 보낸id
	    String member_id = (String) session.getAttribute("id"); // 세션에 담긴 id
	    Map<String, Object> response = new HashMap<>(); // 클라이언트로 보낼 데이터
	    ResponseEntity<Map<String, Object>> result = null; // 클라이언트로 보낼 응답

	    if (!member_id_client.equals(member_id)) {
	        response.put("success", false);
	        response.put("message", "fail");
	        result = ResponseEntity.status(HttpStatus.OK).body(response);
	    } else {
	    	Map<String, Object> memberInfoMap = memberService.getMemberInfoById(map);
	        if (memberInfoMap.get("member_id").equals(member_id)) {
	            response.put("success", true);
	            response.put("message", "confirm");
	            result = ResponseEntity.status(HttpStatus.OK).body(response);
	        } else {
	            response.put("success", false);
	            response.put("message", "fail");
	            result = ResponseEntity.status(HttpStatus.OK).body(response);
	        }
	    }
	    return result;
	}
	
	// 회원 정보 변경 2 - 폼 작성 ------------------------------------------------------------------------------------------
	@PostMapping("/updateMemberInfo2")
	public String updateMemberInfo2(HttpSession session, Model model) {
	    String result = "";
	    String id = (String) session.getAttribute("id");
	    Map paramMap = new HashMap();
	    paramMap.put("member_id",id);
	    

	    if (id != null && !id.isEmpty()) {
	    	Map map = memberService.getMemberInfoById(paramMap);
	    	model.addAttribute("updateMemberInfo",map);
	        result = "/member/personal/updateMemberInfo2";
	    } else {
	        result = "/common/errorPage";
	        model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
	    }
	    return result;
	}
	
	
	@GetMapping("/updateMemberInfo2")
	public String updateMemberInfo2Get(Model model) {
    	model.addAttribute("errorMessage", "잘못된 접근입니다");
	    return "/common/errorPage";
	}
	
	// 회원 정보 변경 처리------------------------------------------------------------------------------------------------
	
	 @PostMapping("updateMemberInfoProcess")
	 public String updateMemberInfoProcess(@RequestParam Map map, Model model){
		 int queryResult = memberService.updateMemberInfo(map);
		 String result ="";
		 
		 if ( 1 == queryResult) {
			 model.addAttribute("result",1);
			 result ="member/personal/updateResult";
		 } else {
			 model.addAttribute("result",0);
			 result ="member/personal/updateResult";
		 }
		 return result;
	  }
	 
	 @GetMapping("updateMemberInfoProcess") //get방식으로 접근하면 메인으로 이동시키기
	 public String updateMemberInfoProcessGet(@RequestParam Map map, Model model){
		 model.addAttribute("errorMessage", "잘못된 접근입니다");
	    return "/common/errorPage";
	 }
	 
	
	// 에러 페이지 ------------------------------------------------------------------------------------------------
	@GetMapping("/errorPage")
	public String errorPage() {
		return "common/errorPage";
	}
	
	// 회원 탈퇴 ----------------------------------------------
	@GetMapping("/withdrawal")
	public String withdrawal(HttpSession Session, Model model) {
		String result="";
		String id = (String)Session.getAttribute("id");
		
		if(id != null && !id.isEmpty()) {
			result= "/member/personal/withdrawal";
		} else {
			result="/common/errorPage";
			model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
		}
		return result;
	}
	
	// 회원 탈퇴 2-------------------------------------------------
	@PostMapping("/withdrawal2")
	public String withdrawal2(HttpSession session, Model model) {
	    String result = "";
	    String id = (String) session.getAttribute("id");
	    Map paramMap = new HashMap();
	    paramMap.put("member_id",id);
	    

	    if (id != null && !id.isEmpty()) {
	    	Map map = memberService.getMemberInfoById(paramMap);
	    	model.addAttribute("withdrawalMemberInfo",map);
	        result = "/member/personal/withdrawal2";
	    } else {
	    	model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
	        result = "/common/errorPage";
	    }
	    return result;
	}
	
	@GetMapping("/withdrawal2")
	public String withdrawal2Get(Model model) {
    	model.addAttribute("errorMessage", "잘못된 접근입니다");
	    return "/common/errorPage";
	}
	
	// 회원 탈퇴 처리-------------------------------------------------
	@PostMapping("withdrawalProccess")
	public String withdrawalProccess (HttpSession session, Model model) {
	    String id = (String) session.getAttribute("id");
	    Map map = new HashMap();
	    String result = "";
	    
	    if (id != null && !id.isEmpty()) {
	    	map.put("member_id", id);
	    	map.put("member_del","y");
		    int delMemberResult = memberService.updateMemberInfo(map);
		    
		    if(1 == delMemberResult) {
		    	//interest에서 해당 member_id삭제
		    	boardService.deleteLike(map);
		    	//board에서 해당 member_id del_yn y로 변경
		    	boardService.deleteBoard(map);
		    	model.addAttribute("result",1);
		    	session.removeAttribute("id");
		        result = "/member/personal/withdrawalResult";
		    } else {
		    	model.addAttribute("result",0);
		        result = "/member/personal/withdrawalResult";
		    }
		    
	    } else {
	    	model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
	        result = "/common/errorPage";
	    }
		return result;
	}
	


}
