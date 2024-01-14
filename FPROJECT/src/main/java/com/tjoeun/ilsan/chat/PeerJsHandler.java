package com.tjoeun.ilsan.chat;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class PeerJsHandler extends TextWebSocketHandler {

    private Map<String, WebSocketSession> sessionMap = new ConcurrentHashMap<>();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // PeerJS에서 전송된 메시지 처리 로직
        // ...
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 새로운 PeerJS 연결이 확립될 때 호출되는 로직
        // ...
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // PeerJS 연결이 닫힐 때 호출되는 로직
        // ...
    }
}
