package com.tjoeun.ilsan.common.file.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.common.file.dao.CommonFileDao;

@Service
@EnableTransactionManagement
public class CommonFileServiceImpl implements CommonFileService {
	
	@Autowired
	CommonFileDao commonFileDao;
	
	@Value("${file.upload.path}")
	private String fileUploadPath;

	@Override
	@Transactional(
			readOnly = false
			,propagation = Propagation.MANDATORY
			,rollbackFor = {Exception.class}
			)
	public void upload(Map map, MultipartFile mFile) throws Exception {
		String o_filename = mFile.getOriginalFilename();
		String n_filename = UUID.randomUUID().toString()+ "-" + o_filename;
		File newFile = new File(fileUploadPath + n_filename);
		try {
			mFile.transferTo(newFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		map.put("o_filename", o_filename);
		map.put("n_filename", n_filename);
		map.put("f_seq", map.get("seq"));
		int result = commonFileDao.insert(map);
		if ( 1 != result ) {
			throw new Exception();
		}
	}

	@Override
	public List<Map> getFileList(Map map) {
		return commonFileDao.select(map);
	}

	@Override
	public void download(Map map, HttpServletResponse res) {
		try {
			Map fMap = commonFileDao.select(map).get(0);
			File file = new File(fileUploadPath + fMap.get("n_filename").toString());
			String mimeType = URLConnection.guessContentTypeFromName(file.getName());
			if (mimeType == null) {
				mimeType = "application/octet-stream";
			}
			res.setContentType(mimeType);
			String encodedFileName = URLEncoder.encode(fMap.get("o_filename").toString(), StandardCharsets.UTF_8.toString());
	        res.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"; filename*=UTF-8''%s", encodedFileName, encodedFileName));
			res.setContentLength((int) file.length());
			InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
			FileCopyUtils.copy(inputStream, res.getOutputStream());
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	
	
	
	
	
	
	
}
