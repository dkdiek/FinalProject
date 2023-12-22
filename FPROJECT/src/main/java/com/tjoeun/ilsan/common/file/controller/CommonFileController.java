package com.tjoeun.ilsan.common.file.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.ilsan.common.file.service.CommonFileService;

@Controller

public class CommonFileController {
	
	@Autowired
	CommonFileService commonFileService;
	
	@RequestMapping(value="/common/file/download", method = RequestMethod.POST)
	@ResponseBody
	public void download(HttpServletResponse res, @RequestParam Map map) {
		 commonFileService.download(map, res);
	}
	
}
