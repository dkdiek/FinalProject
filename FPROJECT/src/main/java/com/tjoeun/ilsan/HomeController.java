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
		double userLatitude =37.5665;
		double userLongitude =126.9780;
		// 사용자 ID를 이용하여 회원 정보 조회
		if (member_id != null) {
			// 회원 정보 가져오기
			Map<String, Object> memberInfo = memberService.getMemberInfoById(member_id);

			if (memberInfo != null) {
				userLatitude = (double) memberInfo.get("latitude");
				userLongitude = (double) memberInfo.get("longitude");
			}
		}		
		// 위도와 경도를 Map에 담아 서비스로 전달
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("userLatitude", userLatitude);
	    paramMap.put("userLongitude", userLongitude);
	    paramMap.put("distance", 3);  // 거리
	    paramMap.put("order", "distance");  // 정렬 기준
	    paramMap.put("limit", 6); // 가져올 개수
	    paramMap.put("soldout_yn", "n"); // 판매완료 아닌것
		    
		List<HashMap<String, Object>> boardList = boardService.selectBoardList(paramMap);
		
		// 현재 시간 구하기
		Date currentDate = new Date();

		// 각 게시물의 create_date와 현재 시간과의 차이를 계산하여 모델에 추가
		
		//boardList1
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
		
		return "home";
	}
	

	
}
