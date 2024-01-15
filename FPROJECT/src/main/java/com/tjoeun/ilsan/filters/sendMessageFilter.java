package com.tjoeun.ilsan.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.tjoeun.ilsan.member.service.MemberService;

@WebFilter("/sendMessage")
public class sendMessageFilter implements Filter {
	
	@Autowired
	MemberService memberService;
	
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession();
        String userId = (String) session.getAttribute("id");
        String fromId = httpRequest.getParameter("from_id");

        if (userId == null || userId.isEmpty() || !userId.equals(fromId)) {
            // 세션에 "id"가 없거나, "from_id" 파라미터와 일치하지 않으면 에러 페이지로 포워딩
            String errorMessage = "올바른 접근이 아닙니다";
            session.setAttribute("errorMessage", errorMessage);
            httpRequest.getRequestDispatcher("/errorPage").forward(request, response);
            return;
        }

        // "id"가 있고, "from_id" 파라미터와 일치하면 다음 필터 또는 요청 처리로 진행
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 메서드
    }

    @Override
    public void destroy() {
        // 필터 소멸 메서드
    }
}
