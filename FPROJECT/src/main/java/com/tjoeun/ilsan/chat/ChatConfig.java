package com.tjoeun.ilsan.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebSocket
@ComponentScan("com.tjoeun.ilsan.chat") // 패키지 경로를 적절하게 수정
public class ChatConfig implements WebSocketConfigurer {

    @Autowired
    PeerJsHandler peerJsHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(peerJsHandler, "/peerjs").setAllowedOrigins("*");
    }
}
