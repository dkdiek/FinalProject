package com.tjoeun.ilsan.common.file.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface CommonFileService {
	
	public void upload(Map map, MultipartFile mFile) throws Exception;
	
	public List<Map> getFileList(Map map);
	
	public void download(Map map, HttpServletResponse res) ;

}
