package com.tjoeun.ilsan.board.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.service.BoardService;
import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	@Autowired
	MemberService memberService;
	
	// 작성 페이지 ------------------------------------------------------------------------------------------
	@GetMapping("/writeView")
	public String writeView(HttpSession session) {
		return "/sales/writeView";
	}
	
	// 작성 처리 ------------------------------------------------------------------------------------------
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
	
	// 디테일뷰 ------------------------------------------------------------------------------------------
	@GetMapping("/detail")
	public String showDetail(@RequestParam("seq") int seq, Model model, HttpSession session) {
	    try {
	        // 조회수 증가 및 성공 여부 확인
	        int updateCount = boardService.increaseViewCount(seq);

	        if (updateCount > 0) {
	            // 성공적으로 조회수가 증가한 경우
	            Map map = new HashMap();
	            map.put("seq", seq);
	            Map boardDetail = boardService.selectBoardDetail(map);

		        // 좋아요 여부를 확인하는 기능
	            String member_id = (String) session.getAttribute("id");
		        if (member_id != null) {
		            Map<String, Object> likeCheckMap = new HashMap<>();
		            likeCheckMap.put("seq", seq);
		            likeCheckMap.put("member_id", member_id);

		            int likeStatus = boardService.checkLikeStatus(likeCheckMap);

		            if (likeStatus > 0) {
		                boardDetail.put("likeStatus", "bi bi-heart-fill"); // 채워진 하트
		            } else {
		            	boardDetail.put("likeStatus", "bi bi-heart"); // 빈 하트
		            }
		        } else {
		            // 회원이 아닌 경우 빈 하트로 표시
		        	boardDetail.put("likeStatus", "bi bi-heart");
		        }
		        
		        // 클라이언트로 전송
		        model.addAttribute("boardDetail", boardDetail);
	            model.addAttribute("imgList", boardDetail.get("imgList"));
	            return "sales/detailView"; // detail.jsp로 포워딩
	        } else {
	            // 조회수 증가 실패
	            model.addAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
	            return "common/errorPage"; // 에러 페이지로 포워딩
	        }
	    } catch (Exception e) {
	        // 예외 발생 시
	        model.addAttribute("errorMessage", "서비스 처리 중 오류가 발생했습니다.");
	        return "common/errorPage"; // 에러 페이지로 포워딩
	    }
	}
	
	/*
	 * // 조건 뷰
	 * -----------------------------------------------------------------------------
	 * -------------
	 * 
	 * @GetMapping("/search") public String showSearch(@RequestParam Map map, Model
	 * model) { int limit = 10; String pageValue = (String) map.get("page"); int
	 * currentPage = (pageValue != null && !pageValue.isEmpty()) ?
	 * Integer.parseInt(pageValue) : 1; int offset = (currentPage - 1) * limit;
	 * 
	 * map.put("limit", limit); map.put("offset", offset); List<Map> boardList =
	 * boardService.searchBoardList(map);
	 * 
	 * Date currentDate = new Date();
	 * 
	 * for (Map<String, Object> board : boardList) { Timestamp createDateTimeStamp =
	 * (Timestamp) board.get("create_date"); Date createDate = new
	 * Date(createDateTimeStamp.getTime());
	 * 
	 * long timeDifference = currentDate.getTime() - createDate.getTime(); long
	 * minutesDifference = timeDifference / (60 * 1000);
	 * 
	 * // 조건에 따라 문자열 생성 String formattedDifference; if (minutesDifference < 60) {
	 * formattedDifference = minutesDifference + "분 전"; } else if (minutesDifference
	 * < (24 * 60)) { long hoursDifference = minutesDifference / 60;
	 * formattedDifference = hoursDifference + "시간 전"; } else if (minutesDifference
	 * < (30 * 24 * 60)) { long daysDifference = minutesDifference / (24 * 60);
	 * formattedDifference = daysDifference + "일 전"; } else { SimpleDateFormat sdf =
	 * new SimpleDateFormat("yyyy-MM-dd"); formattedDifference =
	 * sdf.format(createDate); }
	 * 
	 * board.put("formattedDifference", formattedDifference); }
	 * 
	 * 
	 * int boardCount = boardService.selectBoardCount(map); int totalPages = (int)
	 * Math.ceil((double) boardCount / limit);
	 * 
	 * model.addAttribute("boardList", boardList); model.addAttribute("boardCount",
	 * boardCount); model.addAttribute("totalPages", totalPages);
	 * model.addAttribute("currentPage", currentPage);
	 * 
	 * return "sales/searchView"; }
	 */
	
	
	// 좋아요 처리 ------------------------------------------------------------------------------------------
	@PostMapping("/like")
	@ResponseBody
	public ResponseEntity<String> like(@RequestParam int seq, HttpSession session) {
	    // 세션에서 사용자 ID 가져오기
	    String member_id = (String) session.getAttribute("id");

	    if (member_id == null || member_id.isEmpty()) {
	        // 로그인이 필요한 경우
	        return ResponseEntity.ok("{\"message\": \"login_required\"}");
	    }

	    // 좋아요 여부를 확인하는 기능
	    Map<String, Object> likeCheckMap = new HashMap<>();
	    likeCheckMap.put("seq", seq);
	    likeCheckMap.put("member_id", member_id);

	    return boardService.processLike(likeCheckMap);
	}
	
	// 판매완료 처리 ------------------------------------------------------------------------------------------
	@PostMapping("/soldout")
	@ResponseBody
	public ResponseEntity<String> soldout(@RequestParam("seq") int seq, HttpSession session) {
	    // 세션에서 사용자 ID 가져오기
	    String member_id = (String) session.getAttribute("id");

	    if (member_id == null || member_id.isEmpty()) {
	        // 로그인이 필요한 경우
	        return ResponseEntity.ok("{\"message\": \"login_required\"}");
	    }

	    ResponseEntity<String> soldoutResponse = boardService.soldout(seq);

	    // 판매 완료 처리 결과에 따라 응답 생성
	    if (soldoutResponse.getStatusCode().is2xxSuccessful()) {
	        return ResponseEntity.ok("{\"message\": \"success\"}");
	    } else if (soldoutResponse.getStatusCodeValue() == 404) {
	        return ResponseEntity.ok("{\"message\": \"not_found\"}");
	    } else {
	        return ResponseEntity.status(500).body("{\"message\": \"internal_server_error\"}");
	    }
	}
	
	// 게시물 삭제 처리 ------------------------------------------------------------------------------------------
	@PostMapping("/deleteBoard")
	@ResponseBody
	public ResponseEntity<String> deleteBoard(@RequestParam("seq") int seq, HttpSession session) {
	    // 세션에서 사용자 ID 가져오기
	    String member_id = (String) session.getAttribute("id");

	    if (member_id == null || member_id.isEmpty()) {
	        // 로그인이 필요한 경우
	        return ResponseEntity.ok("{\"message\": \"login_required\"}");
	    }
	    
	    Map soldoutResponseMap = new HashMap();
	    soldoutResponseMap.put("seq", seq);
	    ResponseEntity<String> soldoutResponse = boardService.deleteBoard(soldoutResponseMap);

	    // 판매 완료 처리 결과에 따라 응답 생성
	    if (soldoutResponse.getStatusCode().is2xxSuccessful()) {
	    	//좋아요 삭제 처리
	    	Map delLikeMap = new HashMap();
	    	delLikeMap.put("seq", seq);
	    	boardService.deleteLike(delLikeMap);
	    	
	        return ResponseEntity.ok("{\"message\": \"success\"}");
	    } else if (soldoutResponse.getStatusCodeValue() == 404) {
	        return ResponseEntity.ok("{\"message\": \"not_found\"}");
	    } else {
	        return ResponseEntity.status(500).body("{\"message\": \"internal_server_error\"}");
	    }
	}
		
	// 게시물 수정 ------------------------------------------------------------------------------------------
	@GetMapping("/modifyBoardView")
	public String modifyView(@RequestParam Map map, HttpSession session, Model model) {
		String result="/common/errorPage";
	    String member_id_session = (String) session.getAttribute("id");
	    String member_id_map = (String) map.get("member_id");
	    
	    if ( member_id_map.equals(member_id_session) ) {
	    	 Map<String, Object> boardDetail = boardService.selectBoardDetail(map);
	 	    	model.addAttribute("boardDetail", boardDetail);
	 	    	result = "/sales/modifyView";
	    } else {
	    	 String errorMessage = "조건에 맞는 게시물이 없습니다.";
	         model.addAttribute("errorMessage", errorMessage);
	    }
	    return result;
	}
	
	// 게시물 수정 처리 ------------------------------------------------------------------------------------------
	@PostMapping("/modifyBoardProcess")
	public String modifyBoardProcess(@RequestParam Map map, Model model) {
		String seq = (String) map.get("seq");
		String result = "redirect:/detail?seq=" + seq;
		try {
			int update = boardService.updateBoard(map);
			if (1 == update) {
				result = "redirect:/detail?seq=" + seq;
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage","게시물 수정 오류가 발생하였습니다");
			result = "common/errorPage";

		}
		return result;
	}
	
	
	
	@GetMapping("/search")
	public String showSearch(@RequestParam Map map, Model model, HttpSession session) {
	    int limit = 10;
	    String pageValue = (String) map.get("page");
	    int currentPage = (pageValue != null && !pageValue.isEmpty()) ? Integer.parseInt(pageValue) : 1;
	    int offset = (currentPage - 1) * limit;
	    
	    // 세션에 id가 있는 경우 member 테이블에서 회원 위도 경도 불러오기
	    String member_id = (String) session.getAttribute("id");
	    
	    if (member_id != null && !member_id.isEmpty()) {
	    	map.put("member_id", member_id);
			Map memberInfoMap = memberService.getMemberInfoById(map);
			map.put("userLatitude", memberInfoMap.get("latitude"));
			map.put("userLongitude", memberInfoMap.get("longitude"));
			
			// 클라이언트에 주소 보내기
			model.addAttribute("memberInfoMap",memberInfoMap);
			
	    } else {
	    	// 세션에 id가 없으면 위경도 서울로 세팅
	    	double userLatitude =37.5665851;
			double userLongitude =126.9782038;
			String member_addr2 = "서울특별시 중구 세종대로 110";
	    	map.put("userLatitude", userLatitude);
			map.put("userLongitude", userLongitude);
			
			// 클라이언트에 주소 보내기
			Map memberInfoMap = new HashMap();
			memberInfoMap.put("member_addr2", "서울특별시 중구 세종대로 110");
			model.addAttribute("memberInfoMap",memberInfoMap);
	    }
	    
		
	    
	    map.put("limit", limit);
	    map.put("offset", offset);
	    List<Map> boardList = boardService.searchFilterList(map);

	    Date currentDate = new Date();

	    for (Map<String, Object> board : boardList) {
	        Timestamp createDateTimeStamp = (Timestamp) board.get("create_date");
	        Date createDate = new Date(createDateTimeStamp.getTime());

	        long timeDifference = currentDate.getTime() - createDate.getTime();
	        long minutesDifference = timeDifference / (60 * 1000);

	        // 조건에 따라 문자열 생성
	        String formattedDifference;
	        if (minutesDifference < 60) {
	            formattedDifference = minutesDifference + "분 전";
	        } else if (minutesDifference < (24 * 60)) {
	            long hoursDifference = minutesDifference / 60;
	            formattedDifference = hoursDifference + "시간 전";
	        } else if (minutesDifference < (30 * 24 * 60)) {
	            long daysDifference = minutesDifference / (24 * 60);
	            formattedDifference = daysDifference + "일 전";
	        } else {
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            formattedDifference = sdf.format(createDate);
	        }

	        board.put("formattedDifference", formattedDifference);
	    }


	    int boardCount = boardService.searchFilterListCount(map);
	    int totalPages = (int) Math.ceil((double) boardCount / limit);

	    model.addAttribute("boardList", boardList);
	    model.addAttribute("boardCount", boardCount);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", currentPage);

	    return "sales/searchView";
	}
	

}
