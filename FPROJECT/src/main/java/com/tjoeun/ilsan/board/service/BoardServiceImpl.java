package com.tjoeun.ilsan.board.service;

import java.io.File;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.ilsan.board.dao.BoardDao;

@Service
@EnableTransactionManagement
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDao boardDao;
	
	@Value("${file.upload.path}")
	private String fileUploadPath;
	
	@Override
	@Transactional( readOnly = false ,propagation = Propagation.REQUIRES_NEW
	,rollbackFor = {Exception.class} )
	public int upload(Map map, List<MultipartFile> mFiles, HttpSession session) throws Exception {
		int imgNo=1;
		for (MultipartFile mFile : mFiles) {
            String o_filename = mFile.getOriginalFilename();
            String n_filename = UUID.randomUUID().toString() + "-" + o_filename;
            File newFile = new File(fileUploadPath + n_filename);
            try {
                mFile.transferTo(newFile);
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
			map.put(("img"+imgNo), n_filename);
			imgNo++;
        }
		String memberId = (String) session.getAttribute("id"); // "userId"는 세션에 저장된 사용자 ID의 키 값
		map.put("member_id", memberId);
		int result = boardDao.uploadBoard(map);
		BigInteger seqBigInteger = (BigInteger) map.get("seq");
		int seq = seqBigInteger.intValue();
		if (1 != result) {
			throw new Exception();
		}
		System.out.println(map);
		return seq;
    }

	@Override
	@Transactional
	public Map selectBoardDetail(Map map) {
		Map detailMap = boardDao.selectBoardDetail(map);
		List<String> imgList = new ArrayList();
		for ( int i = 1 ; i < 11 ; i++ ) {
			Object img = detailMap.get("img"+i);
			if ( null != img ) {
				imgList.add(img.toString());
			}
		}
		detailMap.put("imgList", imgList);
		return detailMap;
	}


}
