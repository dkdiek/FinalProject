package com.tjoeun.ilsan.board.free.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.free.dao.FreeBoardDao;
import com.tjoeun.ilsan.common.file.service.CommonFileService;

@Service
@EnableTransactionManagement
public class FreeBoardServiceImpl implements FreeBoardService {
	
	
	@Autowired
	FreeBoardDao freeBoardDao;
	
	@Autowired
	CommonFileService commonFileService;

	@Override
	public long getTotalPage(Map map) {
		Long totalCnt = (Long) freeBoardDao.selectTotalCnt(map).get("totalCnt");
		long page = totalCnt / 10;
		if(0 < totalCnt % 10) {
			page ++;
		}
		return page;
	}
	
	@Override
	public List<Map> list(Map map) {
		
		Object page = map.get("page");
		if( null == page || "".equals(page) ) {
			map.put("limit", 10);
			map.put("offset", 0);
			map.put("page", 1);
			
		} else {
			int iPage = Integer.parseInt((String)page);
			map.put("limit", 10);
			map.put("offset", 10 * (iPage - 1));
			
		}
		return freeBoardDao.select(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public void write(Map map, MultipartFile mFile) throws Exception {
		map.put("writer", "hongkdManual");
		int result = freeBoardDao.write(map);
		if (1 != result) {
			throw new Exception();
		}
		if( !"".contentEquals(mFile.getOriginalFilename()) ) {
			commonFileService.upload(map, mFile);
		}
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public void delete(Map map) throws Exception {
		int result = freeBoardDao.delete(map);
		if (1 != result) {
			throw new Exception();
		}
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public void update(Map map) throws Exception {
		int result = freeBoardDao.update(map);
		if (1 != result) {
			throw new Exception();
		}
	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public void updateRec(Map map) throws Exception {
		int result = freeBoardDao.updateRec(map);
		if (1 != result) {
			throw new Exception();
		}
	}


}
