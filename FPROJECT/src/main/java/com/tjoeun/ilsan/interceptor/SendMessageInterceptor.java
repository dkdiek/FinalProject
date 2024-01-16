package com.tjoeun.ilsan.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.tjoeun.ilsan.member.service.MemberService;

import oracle.jdbc.proxy.annotation.Pre;

@Component
public class SendMessageInterceptor implements HandlerInterceptor {
	
	@Autowired
	MemberService memberService;
	
	// 메시지 보내기 url에 받는 상대 아이디가 존재하지 않으면 에러 페이지로 이동 시킴
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	System.out.println("SendMessageInterceptor preHandle method is called");
    	
    	String toId = request.getParameter("to_id");
        Map map = new HashMap();
        map.put("member_id", toId);
        Map resultMap = memberService.checkDuplication(map);
        
        if (resultMap == null || resultMap.isEmpty()) {
        	
        	HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "올바른 접근이 아닙니다");
        	response.sendRedirect("/errorPage");
        	return false;
        } else {
        	
        	return true;
        }
        
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
    	 
        // 컨트롤러 메소드가 실행된 후, View로 forward 되기 전에 실행되는 로직
        System.out.println("postHandle method is called");
        
        
        String toId = request.getParameter("to_id");
        Map map = new HashMap();
        map.put("member_id", toId);
        Map resultMap = memberService.checkDuplication(map);
        
        if (resultMap == null || resultMap.isEmpty()) {
        	
        	HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "올바른 접근이 아닙니다");
        	response.sendRedirect("/errorPage");
        } 
        
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // View가 렌더링된 후에 실행되는 로직
        System.out.println("afterCompletion method is called");
        
        String toId = request.getParameter("to_id");
        Map map = new HashMap();
        map.put("member_id", toId);
        Map resultMap = memberService.checkDuplication(map);
        
        if (resultMap == null || resultMap.isEmpty()) {
        	
        	HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "올바른 접근이 아닙니다");
        	response.sendRedirect("/errorPage");
        } 
    }
}