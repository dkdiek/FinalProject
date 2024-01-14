package com.tjoeun.ilsan.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    @MessageMapping("/chat/{sellerId}/{buyerId}")
    @SendTo("/topic/chat/{sellerId}/{buyerId}")
    public String handleChatMessage(String message) {
        // 메시지 처리 로직을 구현하고, 필요에 따라 데이터베이스에 저장
        return message;
    }
}
