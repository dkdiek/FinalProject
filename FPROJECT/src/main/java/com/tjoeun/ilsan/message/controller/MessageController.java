package com.tjoeun.ilsan.message.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.tjoeun.ilsan.message.service.MessageService;

@Controller
public class MessageController {
	
	@Autowired
	MessageService messageService;
	
	//  쪽지 보내기------------------------------------------------------------------------------
	@GetMapping("/sendMessage")
	public String enterChat(Model model, @RequestParam Map map, HttpSession session, HttpServletRequest request) {
		
		model.addAttribute("info",map);
		return "member/message/sendMessage";
	}
	
	/*
	 * @PostMapping("/sendMessageProcess")
	 * 
	 * @ResponseBody public ResponseEntity<String> sendMessageProcess(@RequestParam
	 * Map map) { int result = messageService.sendMessage(map);
	 * 
	 * if (result > 0) { return ResponseEntity.ok("success"); } else { return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error"); } }
	 */
	 @PostMapping("/sendMessageProcess")
    @ResponseBody
    public ResponseEntity<String> sendMessageProcess(@RequestBody Map<String, String> data) {
        int result = messageService.sendMessage(data);

        if (result > 0) {
            return ResponseEntity.ok("{\"message\": \"success\"}");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"message\": \"error\"}");
        }
    }
	
	
	@GetMapping("/messageList")
	public String messageList(@RequestParam Map<String, Object> map, Model model, HttpSession session) {
	    String member_id = (String) session.getAttribute("id");
	    map.put("member_id", member_id);

	    int limit = 10; // 페이지당 표시할 항목 수
	    int page = 1; // 기본 페이지 번호

	    if (map.containsKey("page")) {
	        page = Integer.parseInt((String) map.get("page"));
	    }

	    int offset = (page - 1) * limit;
	    
	    map.put("limit", limit);
	    map.put("offset", offset);

	    List<Map> result = messageService.selectMessageList(map);
	    int resultCnt = messageService.selectMessageListCnt(map);

	    int totalPages = (int) Math.ceil((double) resultCnt / limit);

	    model.addAttribute("result", result);
	    model.addAttribute("resultCnt", resultCnt);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);

	    return "/member/message/messageList";
	}
	
	@GetMapping("/messageList2")
	public String messageList2(@RequestParam Map<String, Object> map, Model model, HttpSession session) {
	    String member_id = (String) session.getAttribute("id");
	    map.put("member_id", member_id);

	    int limit = 10; // 페이지당 표시할 항목 수
	    int page = 1; // 기본 페이지 번호

	    if (map.containsKey("page")) {
	        page = Integer.parseInt((String) map.get("page"));
	    }

	    int offset = (page - 1) * limit;
	    
	    map.put("limit", limit);
	    map.put("offset", offset);

	    List<Map> result = messageService.selectMessageList2(map);
	    int resultCnt = messageService.selectMessageListCnt2(map);

	    int totalPages = (int) Math.ceil((double) resultCnt / limit);

	    model.addAttribute("result", result);
	    model.addAttribute("resultCnt", resultCnt);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);

	    return "/member/message/messageList2";
	}
	
	@GetMapping("/updateMessageRead")
	public ResponseEntity<String> updateMessageRead(@RequestParam Map map) {
	    int result = messageService.updateMessageRead(map);

	    if (result > 0) {
	        // 성공적으로 업데이트된 경우
	        return ResponseEntity.ok("success");
	    } else {
	        // 대상이 없거나 이미 업데이트된 경우
	        return ResponseEntity.ok("failure");
	    }
	}
	


}
