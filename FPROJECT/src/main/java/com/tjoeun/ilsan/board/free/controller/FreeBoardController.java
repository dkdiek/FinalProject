package com.tjoeun.ilsan.board.free.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.free.service.FreeBoardService;
import com.tjoeun.ilsan.common.file.service.CommonFileService;

@Controller
public class FreeBoardController {
	
	
	@Autowired
	FreeBoardService freeBoardService;
	
	@Autowired
	CommonFileService commonFileService;
	
	@RequestMapping(value="/board/free/detail", method = RequestMethod.GET)
	public String detail(
			Model model
			, @RequestParam Map map
			) throws Exception {
		
		model.addAttribute("free", freeBoardService.list(map).get(0));
		
		Map fMap = new HashMap();
		fMap.put("f_seq", map.get("seq"));
		List<Map> files = commonFileService.getFileList(fMap);
		if ( 0 < files.size() ) {
			model.addAttribute("file", files.get(0));
		}
		
		return "board/free/detail";
	}

	@RequestMapping(value="/board/free/listView", method = {RequestMethod.GET, RequestMethod.POST})
	public String listView(Model model, @RequestParam Map map) throws Exception {
		model.addAttribute("list",freeBoardService.list(map));
		model.addAttribute("totalPage",freeBoardService.getTotalPage(map));
		model.addAttribute("rp",map);
		
		return "board/free/listView";
	}
	
	@RequestMapping(value="/board/free/writeView", method = RequestMethod.GET)
	public String writeView() {
		return "board/free/writeView";
	}

	@RequestMapping(value="/board/free/write", method = RequestMethod.POST)
	public String write(@RequestParam Map map, @RequestParam(value = "file") MultipartFile mFile) throws Exception {
		freeBoardService.write(map, mFile);
		return "redirect:/";
	}

	@RequestMapping(value="/board/free/delete", method = RequestMethod.POST)
	public String delete(@RequestParam Map map) throws Exception {
		freeBoardService.delete(map);
		return "redirect:/";
	}

	@RequestMapping(value="/board/free/updateView", method = RequestMethod.GET)
	public String updateView(Model model, @RequestParam Map map) throws Exception {
		
		model.addAttribute("free",freeBoardService.list(map).get(0));

		return "board/free/updateView";
	}

	@RequestMapping(value="/board/free/update", method = RequestMethod.POST)
	public String update(@RequestParam Map map) throws Exception {
		freeBoardService.update(map);
		return "redirect:/";
	}
	
	@RequestMapping(value="/board/free/updateRec", method = RequestMethod.POST)
	@ResponseBody //ajax할때는 붙여야함 화면리프레쉬x
	public Map updateRec(@RequestParam Map map) {
		Map resultMap = new HashMap();
		try {
			freeBoardService.updateRec(map);
			resultMap.put("result", "success");
			resultMap.put("data", freeBoardService.list(map).get(0));
		}catch(Exception e) {
			e.printStackTrace(); 
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	
}
