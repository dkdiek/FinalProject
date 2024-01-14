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

@WebFilter("/writeView")
public class WriteViewFilter implements Filter {
	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession();
        String userId = (String) session.getAttribute("id");

        if (userId == null || userId.isEmpty()) {
            // 세션에 "id"가 없으면 errorPage로 리다이렉트
            String errorMessage = "회원만 접근 가능한 메뉴입니다";
            session.setAttribute("errorMessage", errorMessage);
            httpResponse.sendRedirect("/errorPage");
            return;
        }

        // "id"가 있으면 다음 필터 또는 요청 처리로 진행
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