package com.tjoeun.ilsan.board.free.reply.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.ilsan.board.free.reply.service.FreeBoardRepService;

@Controller
public class FreeBoardRepController {
	
	@Autowired
	FreeBoardRepService freeBoardRepService;
	
	@RequestMapping(value = "/board/free/addRep", method = RequestMethod.POST)
	@ResponseBody
	public Map addRep(@RequestParam Map map){
		Map result = new HashMap();
		try {
			freeBoardRepService.insert(map);
			result.put("data", freeBoardRepService.select(map));
			result.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "fail");
		}
		return result;
	}
	
	@RequestMapping(value = "/board/free/getRep", method = RequestMethod.POST)
	@ResponseBody
	public Map getRep(@RequestParam Map map){
		Map result = new HashMap();
		try {
			result.put("data", freeBoardRepService.select(map));
			result.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "fail");
		}
		return result;
	}
	

}
