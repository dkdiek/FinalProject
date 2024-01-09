package com.tjoeun.ilsan.board.service;

import java.io.File;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
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
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int upload(Map map, List<MultipartFile> mFiles, HttpSession session) throws Exception {
	    int imgNo = 1;
	    List<String> uploadedFileNames = new ArrayList<>();
	    int seq = 0; // seq 변수를 try-catch 블록 외부에서 선언 및 초기화

	    try {
	        for (MultipartFile mFile : mFiles) {
	            String o_filename = mFile.getOriginalFilename();
	            String n_filename = UUID.randomUUID().toString() + "-" + o_filename;
	            File newFile = new File(fileUploadPath + n_filename);

	            try {
	                mFile.transferTo(newFile);
	                uploadedFileNames.add(n_filename);
	            } catch (Exception e) {
	                e.printStackTrace();
	                throw e;
	            }

	            map.put("img" + imgNo, n_filename);
	            imgNo++;
	        }

	        String memberId = (String) session.getAttribute("id");
	        map.put("member_id", memberId);
	        int result = boardDao.uploadBoard(map);
	        BigInteger seqBigInteger = (BigInteger) map.get("seq");
	        if (seqBigInteger != null) {
	            seq = seqBigInteger.intValue();
	        } else {
	            throw new Exception("seq is null");
	        }

	        if (result != 1) {
	            // 등록 실패 시 롤백
	            throw new Exception("Board upload failed");
	        }
	    } catch (Exception e) {
	        // 롤백이 발생하면 업로드된 파일 삭제
	        for (String fileName : uploadedFileNames) {
	            File fileToDelete = new File(fileUploadPath + fileName);
	            if (fileToDelete.exists()) {
	                fileToDelete.delete();
	            }
	        }
	        throw e;
	    }

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

	
	@Override
	@Transactional
	public List selectBoardList(Map map) {
		
		List BoardList = boardDao.selectBoardList(map);
		return BoardList;
	}

	@Override
	@Transactional
	public List<Map> searchBoardList(Map map) {
		List BoardList = boardDao.searchBoardList(map);
		return BoardList;
	}

	@Override
	@Transactional
	public int selectBoardCount(Map map) {
		int BoardCnt = boardDao.selectBoardCount(map);
		return BoardCnt;
	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
     public int increaseViewCount(int seq) {
        int result = boardDao.increaseViewCount(seq);
        return result;
    }


	@Override
	@Transactional
	public int checkLikeStatus(Map map) {
		int result = boardDao.checkLikeStatus(map);
        return result;
	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public ResponseEntity<String> processLike(Map map) {
	    try {
	        int likeStatus = boardDao.checkLikeStatus(map);

	        if (likeStatus > 0) {
	            // 이미 좋아요를 누른 경우, 좋아요 취소
	            boardDao.cancelLike(map);
	            return ResponseEntity.ok("{\"message\": \"success_cancel\"}");
	        } else {
	            // 좋아요 추가
	            boardDao.addLike(map);
	            return ResponseEntity.ok("{\"message\": \"success_add\"}");
	        }
	    } catch (Exception e) {
	        // 좋아요 처리 중 오류 발생 시
	        return ResponseEntity.ok("{\"message\": \"error\"}");
	    }
	}
	
	// 판매 완료 처리
    @Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
    public ResponseEntity<String> soldout(int seq) {
        int rowsAffected = boardDao.soldout(seq);

        // rowsAffected 값을 기반으로 적절한 응답 생성
        if (rowsAffected > 0) {
            return ResponseEntity.ok("Success"); // 성공적으로 업데이트됨
        } else {
            return ResponseEntity.status(404).body("Not Found"); // 해당 seq를 찾을 수 없음
        }
    }
    
    // 게시물 삭제 처리
    @Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
    public ResponseEntity<String> deleteBoard(int seq) {
        int rowsAffected = boardDao.deleteBoard(seq);
        
        // 좋아요 테이블 데이터 삭제
        Map map = new HashMap();
        map.put("seq", seq);
        boardDao.cancelLike(map);

        // rowsAffected 값을 기반으로 적절한 응답 생성
        if (rowsAffected > 0) {
            return ResponseEntity.ok("Success"); // 성공적으로 업데이트됨
        } else {
            return ResponseEntity.status(404).body("Not Found"); // 해당 seq를 찾을 수 없음
        }
    }
    
    @Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW, rollbackFor = { Exception.class })
	public int updateBoard(Map map) throws Exception {
    		int result = 0;
	        String seq  = (String) map.get("seq");
	        
	        if (seq != null && !seq.isEmpty()) {
	        	result = boardDao.updateBoard(map);
	        } else {
	            throw new Exception("seq is null");
	        }

	        if (result != 1) {
	            // 등록 실패 시 롤백
	            throw new Exception("Board update failed");
	        }
	   
	    return result;
	}
    
}
