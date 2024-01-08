package com.tjoeun.ilsan;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tjoeun.ilsan.board.service.BoardService;
import com.tjoeun.ilsan.member.service.MemberService;

@Controller
public class HomeController {
	
	@Autowired
	BoardService boardService;
	@Autowired
	MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	// home.jsp 뷰 ------------------------------------------------------------------------------------------
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		// 세션에서 사용자 ID 가져오기
		String member_id = (String) session.getAttribute("id");

		// 비회원일 경우 기본 위치 설정 (서울시)
		double userLatitude =37.5665851;
		double userLongitude =126.9782038;
		String member_addr2 = "서울특별시 중구 세종대로 110";
		// 사용자 ID를 이용하여 회원 정보 조회
		if (member_id != null) {
			// 회원 정보 가져오기
			Map<String, Object> memberInfo = memberService.getMemberInfoById(member_id);

			if (memberInfo != null) {
				userLatitude = (double) memberInfo.get("latitude");
				userLongitude = (double) memberInfo.get("longitude");
				member_addr2 = (String) memberInfo.get("member_addr2");
			}
		}
		
		// 홈 상단 메뉴-----------------------------------------------------------------
		// 위도와 경도를 Map에 담아 서비스로 전달
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("userLatitude", userLatitude);
	    paramMap.put("userLongitude", userLongitude);
	    paramMap.put("distance_from", 0);  // 거리 시작
	    if (member_id != null) {
		    paramMap.put("distance_to", 10);  // 거리 끝
		} else {
			paramMap.put("distance_to", 50);  // 거리 끝
		}
	    paramMap.put("order", "like_cnt");  // 정렬 기준
	    paramMap.put("order_desc", "DESC");  // 정렬 기준
	    paramMap.put("order2", "a.distance");  // 정렬 기준2
	    paramMap.put("order_desc2", "ASC");  // 정렬 기준2
	    paramMap.put("limit", 6); // 가져올 개수
	    paramMap.put("soldout_yn", "n"); // 판매완료 아닌것
	    paramMap.put("member_addr2", member_addr2); // 멤버 주소
		    
		List<HashMap<String, Object>> boardList = boardService.selectBoardList(paramMap);
		
		// 현재 시간 구하기
		Date currentDate = new Date();

		// 각 게시물의 create_date와 현재 시간과의 차이를 계산하여 모델에 추가
		
		for (HashMap<String, Object> board : boardList) {
			// create_date를 Timestamp 객체로 변환
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
	        
	        // 좋아요 여부를 확인하는 기능
	        if (member_id != null) {
	            Map<String, Object> likeCheckMap = new HashMap<>();
	            likeCheckMap.put("seq", board.get("seq"));
	            likeCheckMap.put("member_id", member_id);

	            int likeStatus = boardService.checkLikeStatus(likeCheckMap);

	            if (likeStatus > 0) {
	                board.put("likeStatus", "bi bi-heart-fill"); // 채워진 하트
	            } else {
	                board.put("likeStatus", "bi bi-heart"); // 빈 하트
	            }
	        } else {
	            // 회원이 아닌 경우 빈 하트로 표시
	            board.put("likeStatus", "bi bi-heart");
	        }
	        
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("memberInfo", paramMap);

		
		// 홈 하단 메뉴-----------------------------------------------------------------
	    Map<String, Object> paramMap2 = new HashMap<>();
	    paramMap2.put("userLatitude", userLatitude);
	    paramMap2.put("userLongitude", userLongitude);
	    paramMap2.put("distance_from", 0);  // 거리 시작
	    if (member_id != null) {
		    paramMap2.put("distance_to", 100);  // 거리 끝
		} else {
			paramMap2.put("distance_to", 100);  // 거리 끝
		}
	    paramMap2.put("order", "create_date");  // 정렬 기준
	    paramMap2.put("order_desc", "DESC");  // 정렬 기준
	    paramMap2.put("order2", "a.distance");  // 정렬 기준2
	    paramMap2.put("order_desc2", "ASC");  // 정렬 기준2
	    paramMap2.put("limit", 6); // 가져올 개수
	    paramMap2.put("soldout_yn", "n"); // 판매완료 아닌것
		    
		List<HashMap<String, Object>> boardList2 = boardService.selectBoardList(paramMap2);
		
		// 현재 시간 구하기
		Date currentDate2 = new Date();

		// 각 게시물의 create_date와 현재 시간과의 차이를 계산하여 모델에 추가
		
		//boardList1
		for (HashMap<String, Object> board2 : boardList2) {
			// create_date를 Timestamp 객체로 변환
			Timestamp createDateTimeStamp2 = (Timestamp) board2.get("create_date");
			Date createDate2 = new Date(createDateTimeStamp2.getTime());
			
			long timeDifference2 = currentDate.getTime() - createDate2.getTime();
			long minutesDifference2 = timeDifference2 / (60 * 1000);
			
			// 조건에 따라 문자열 생성
	        String formattedDifference2;
	        if (minutesDifference2 < 60) {
	            formattedDifference2 = minutesDifference2 + "분 전";
	        } else if (minutesDifference2 < (24 * 60)) {
	            long hoursDifference2 = minutesDifference2 / 60;
	            formattedDifference2 = hoursDifference2 + "시간 전";
	        } else if (minutesDifference2 < (30 * 24 * 60)) {
	            long daysDifference2 = minutesDifference2 / (24 * 60);
	            formattedDifference2 = daysDifference2 + "일 전";
	        } else {
	            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	            formattedDifference2 = sdf2.format(createDate2);
	        }

	        board2.put("formattedDifference", formattedDifference2);
	        
	        // 좋아요 여부를 확인하는 기능
	        if (member_id != null) {
	            Map<String, Object> likeCheckMap2 = new HashMap<>();
	            likeCheckMap2.put("seq", board2.get("seq"));
	            likeCheckMap2.put("member_id", member_id);

	            int likeStatus = boardService.checkLikeStatus(likeCheckMap2);

	            if (likeStatus > 0) {
	                board2.put("likeStatus", "bi bi-heart-fill"); // 채워진 하트
	            } else {
	                board2.put("likeStatus", "bi bi-heart"); // 빈 하트
	            }
	        } else {
	            // 회원이 아닌 경우 빈 하트로 표시
	            board2.put("likeStatus", "bi bi-heart");
	        }
	        
		}
		model.addAttribute("boardList2", boardList2);
		model.addAttribute("memberInfo2", paramMap2);

		
		
		return "home";
	}
	

	
}
