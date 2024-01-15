package com.tjoeun.ilsan.member.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.tjoeun.ilsan.mail.EmailService;
import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	BoardService boardService;
	@Autowired
	EmailService emailService;

	
	// 로그인 ------------------------------------------------------------------------------------------
	@PostMapping("/login")
	@ResponseBody
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password,
			@RequestParam(name = "returnUrl", required = false) String returnUrl, HttpSession session) {
		boolean loginResult = memberService.checkLogin(id, password);

		if (loginResult) {
			session.setAttribute("loginType", "Home");
			session.setAttribute("id", id);
			String redirectUrl = (returnUrl != null && !returnUrl.isEmpty()) ? returnUrl : "/";
			String checkLoginSession = (String) session.getAttribute("id");
			System.out.println("로그인 체크" + checkLoginSession);
			// JSON 형태로 응답
			return ResponseEntity.ok("{\"message\": \"success\", \"returnUrl\": \"" + redirectUrl + "\"}");
		} else {
			return ResponseEntity.status(401).body("{\"message\": \"fail\"}");
		}
	}

	
	// 로그아웃 ------------------------------------------------------------------------------------------
	@GetMapping("/logout")
	public String logout(HttpSession session, @RequestParam(name = "returnUrl", required = false) String returnUrl, HttpServletRequest req, HttpServletResponse res) {
		// 세션에서 사용자 정보 제거
		if (session.getAttribute("id") != null) {
			session.removeAttribute("id");
		}
		if (session.getAttribute("loginType") != null) {
			session.removeAttribute("loginType");
		}
		// 세션을 무효화
		session.invalidate();
		// returnUrl이 제공된 경우 해당 페이지로 리다이렉트, 그렇지 않은 경우 기본 리다이렉트 설정
		return "redirect:" + (returnUrl != null ? returnUrl : "/");
	}
	
	//카카오 로그인 ------------------------------------------------------------------------------------------
	@PostMapping("/kakaoLogin")
	@ResponseBody
	public Map<String, Object> kakaoLogin(@RequestBody Map map, HttpSession session, Model model) {
	    Map<String, Object> responseMap = (Map<String, Object>) map.get("response");
		//클라이언트에서 보낸 email을 member_id로 설정
	    String member_id = (String) ((Map<String, Object>) responseMap.get("kakao_account")).get("email");
	    // member_id에 위에 값을 put
	    map.put("member_id", member_id);
	    // 위에 담은 map을 db에 존재하는지 조회
	    Map checkSocialMember = memberService.checkSocialMember(map);

	    // 존재하면
	    if (checkSocialMember != null) {
	        // 세션에 아이디를 담는다 (로그인처리)
	    	session.setAttribute("loginType", "Kakao");
	        session.setAttribute("id", member_id);
	        return Collections.singletonMap("message", "success");
	    } else {
	    	Map joinMap = new HashMap();
	        model.addAttribute("member_info", map);
	        // 클라이언트로 member_id를 함께 응답
	        Map<String, Object> joinKakaoMap = new HashMap<>();
	        joinKakaoMap.put("message", "redirect");
	        joinKakaoMap.put("member_id", member_id);
	        return joinKakaoMap;
	    }
    
	}
	
	//카카오 최초 회원 정보 추가 입력 ------------------------------------------------------------------------------------------
	
	 @GetMapping("/joinKakaoMember") public String joinKakaoMember(Model model){
	 model.addAttribute("errorMessage","올바른 접근이 아닙니다");
	 return "/common/errorPage";
	 }
	 
	@PostMapping("/joinKakaoMember")
	public String joinKakaoMember(@RequestParam Map map, Model model){
		
		String member_id = (String)map.get("member_id");
		Map result = new HashMap();
		result.put("member_id",member_id);
		model.addAttribute("result",map);
		return "/member/join/joinKakaoMember";
		
	}

	
	
	// 회원가입------------------------------------------------------------------------------------------

	// 네이버 로그인 http://localhost/naverLogin
	// azdDptdhj5zpBKzKMGuq
	// Irj41To1KM

	// 회원가입 1단계 - 약관
	@GetMapping("/joinMembership")
	public String joinMember() {
		return "member/join/joinMember";
	}

	// 회원가입 2단계 - 정보 입력
	@GetMapping("/joinMembership2")
	public String joinMember2() {
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

	// 회원 가입
	// 처리------------------------------------------------------------------------------------------

	@PostMapping("/joinProcess")
	public String joinProcess(@RequestParam Map map, Model model) {
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

	// 회원 가입 결과
	// 페이지-------------------------------------------------------------------------------------
	@GetMapping("/joinResult")
	public String joinResult(@RequestParam(name = "result", defaultValue = "0") int result, Model model) {
		model.addAttribute("result", result);
		return "member/join/joinResult";
	}

	// 회원 정보 변경 1
	// ------------------------------------------------------------------------------------------
	@GetMapping("/updateMemberInfo")
	public String updateMemberInfo(HttpSession Session, Model model) {
		String result = "";
		String id = (String) Session.getAttribute("id");

		if (id != null && !id.isEmpty()) {
			result = "/member/personal/updateMemberInfo1";
		} else {
			result = "/common/errorPage";
			model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
		}
		return result;
	}

	// 회원 정보 변경 2 - 비밀번호
	// 재확인-------------------------------------------------------------------------------------
	@PostMapping("/checkMemberAccount")
	public ResponseEntity<Map<String, Object>> checkMemberAccount(@RequestBody Map map, HttpSession session) {

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

	// 회원 정보 변경 2 - 폼 작성
	// ------------------------------------------------------------------------------------------
	@PostMapping("/updateMemberInfo2")
	public String updateMemberInfo2(HttpSession session, Model model) {
		String result = "";
		String id = (String) session.getAttribute("id");
		Map paramMap = new HashMap();
		paramMap.put("member_id", id);

		if (id != null && !id.isEmpty()) {
			Map map = memberService.getMemberInfoById(paramMap);
			model.addAttribute("updateMemberInfo", map);
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

	// 회원 정보 변경
	// 처리------------------------------------------------------------------------------------------------

	@PostMapping("updateMemberInfoProcess")
	public String updateMemberInfoProcess(@RequestParam Map map, Model model) {
		int queryResult = memberService.updateMemberInfo(map);
		String result = "";

		if (1 == queryResult) {
			model.addAttribute("result", 1);
			result = "member/personal/updateResult";
		} else {
			model.addAttribute("result", 0);
			result = "member/personal/updateResult";
		}
		return result;
	}

	@GetMapping("updateMemberInfoProcess") // get방식으로 접근하면 메인으로 이동시키기
	public String updateMemberInfoProcessGet(@RequestParam Map map, Model model) {
		model.addAttribute("errorMessage", "잘못된 접근입니다");
		return "/common/errorPage";
	}

	// 에러 페이지
	// ------------------------------------------------------------------------------------------------
	@GetMapping("/errorPage")
	public String errorPage() {
		return "common/errorPage";
	}

	// 회원 탈퇴 ----------------------------------------------
	@GetMapping("/withdrawal")
	public String withdrawal(HttpSession Session, Model model) {
		String result = "";
		String id = (String) Session.getAttribute("id");

		if (id != null && !id.isEmpty()) {
			result = "/member/personal/withdrawal";
		} else {
			result = "/common/errorPage";
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
		paramMap.put("member_id", id);

		if (id != null && !id.isEmpty()) {
			Map map = memberService.getMemberInfoById(paramMap);
			model.addAttribute("withdrawalMemberInfo", map);
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
	public String withdrawalProccess(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		Map map = new HashMap();
		String result = "";

		if (id != null && !id.isEmpty()) {
			map.put("member_id", id);
			map.put("member_del", "y");
			int delMemberResult = memberService.updateMemberInfo(map);

			if (1 == delMemberResult) {
				// interest에서 해당 member_id삭제
				boardService.deleteLike(map);
				// board에서 해당 member_id del_yn y로 변경
				boardService.deleteBoard(map);
				model.addAttribute("result", 1);
				session.removeAttribute("id");
				result = "/member/personal/withdrawalResult";
			} else {
				model.addAttribute("result", 0);
				result = "/member/personal/withdrawalResult";
			}

		} else {
			model.addAttribute("errorMessage", "회원만 접근 가능한 메뉴입니다");
			result = "/common/errorPage";
		}
		return result;
	}

	// 계정 찾기-------------------------------------------------
	@GetMapping("/findAccount")
	public String findAccount() {
		return "/member/personal/findAccount";
	}

	@PostMapping("/findAccountProcess")
	@ResponseBody
	public ResponseEntity<Map<String, String>> findAccountProcess(@RequestBody Map<String, Object> map) {
		// 요청 타입 확인
		String type = (String) map.get("type");

		// 사용자에게 보낼 응답 메시지
		Map<String, String> response = new HashMap<>();

		if ("id".equals(type)) {
			// ID 찾기 로직 수행
			Map findIdResult = memberService.findAccount(map);

			if (findIdResult != null && !findIdResult.isEmpty()) {
				String member_email = (String) findIdResult.get("member_email");
				String member_id = (String) findIdResult.get("member_id");

				// 메일 발송
				boolean emailSent = emailService.sendIdByEmail(member_email, member_id);

				if (emailSent) {
					response.put("result", "success");
					response.put("message", "ID 전송 완료");
				} else {
					response.put("result", "fail");
					response.put("message", "이메일 전송 실패");
				}
			} else {
				response.put("result", "fail");
				response.put("message", "ID 찾기 실패");
			}
		} else if ("pw".equals(type)) {

			// ID 찾기 로직 수행
			Map findPwResult = memberService.findAccount(map);

			if (findPwResult != null && !findPwResult.isEmpty()) {
				String member_email = (String) findPwResult.get("member_email");
				String member_pw = (String) findPwResult.get("member_pw");

				// 메일 발송
				boolean emailSent = emailService.sendPwByEmail(member_email, member_pw);

				if (emailSent) {
					response.put("result", "success");
					response.put("message", "PW 전송 완료");
				} else {
					response.put("result", "fail");
					response.put("message", "이메일 전송 실패");
				}
			} else {
				response.put("result", "fail");
				response.put("message", "PW 찾기 실패");
			}
		} else {
			// 잘못된 타입일 경우
			response.put("result", "error");
			response.put("message", "잘못된 요청 타입입니다.");
		}

		return ResponseEntity.ok(response);
	}

	
	//  관심 목록------------------------------------------------------------------------------
	@GetMapping("/likeList")
	public String likeList(HttpSession session, Model model) {

		// member_id로 interest 보드에서 like한 게시물 seq가져오기
		String member_id = (String) session.getAttribute("id");
		Map map = new HashMap();
		map.put("member_id", member_id);
		List likeList = boardService.selectBoardsWithInterest(map);

		model.addAttribute("likeList", likeList);

		return "member/personal/likeList";
	}

}
