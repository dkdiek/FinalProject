package com.tjoeun.ilsan.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.tjoeun.ilsan.member.dao.MemberDao;

@Service
@EnableTransactionManagement

public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao memberDao;

	@Override
	public boolean checkLogin(String username, String password) {
		try {
            // Map에 아이디와 비밀번호를 담아서 DAO에 전달
            Map<String, Object> params = new HashMap<>();
            params.put("id", username);
            params.put("password", password);

            // DAO를 통해 로그인 확인을 수행
            Map<String, Object> result = memberDao.checkLogin(params);

            // 로그인 결과 확인
            return result != null && !result.isEmpty();
        } catch (Exception e) {
            // 예외 처리: 실제로는 로깅 등을 통해 예외를 기록하고, 웹 서비스에는 적절한 오류 메시지를 반환하는 것이 좋습니다.
            e.printStackTrace();
            return false; // 예외가 발생하면 로그인 실패로 처리
        }
    }

}
