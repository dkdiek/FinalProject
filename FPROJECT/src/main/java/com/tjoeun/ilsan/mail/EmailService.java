package com.tjoeun.ilsan.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    @Autowired
    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public boolean sendIdByEmail(String email, String id) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("ID 찾기 결과");
            message.setText("회원님의 ID는 " + id + " 입니다.");

            mailSender.send(message);

            return true; // 이메일 전송 성공
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 이메일 전송 실패
        }
    }

    public boolean sendPwByEmail(String email, String pw) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("비밀번호 찾기 결과");
            message.setText("회원님의 PW는 " + pw + " 입니다.");

            mailSender.send(message);

            return true; // 이메일 전송 성공
        } catch (Exception e) {
            e.printStackTrace();
            return false; // 이메일 전송 실패
        }
    }

    

    
    
}