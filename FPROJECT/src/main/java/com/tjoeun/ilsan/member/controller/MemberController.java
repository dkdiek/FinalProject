package com.tjoeun.ilsan.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberController {
	
	
	@RequestMapping(value="member/join/joinMember", method = RequestMethod.GET)
	public String joinMember( ) {
		return "member/join/joinMember";
	}
	
	@RequestMapping(value="member/join/joinMember2", method = RequestMethod.GET)
	public String joinMember2( ) {
		return "member/join/joinMember2";
	}

	
}
