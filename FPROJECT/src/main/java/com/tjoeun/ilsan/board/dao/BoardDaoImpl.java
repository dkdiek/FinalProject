package com.tjoeun.ilsan.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.ilsan.board.sql.BoardMapper;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int uploadBoard(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.uploadBoard(map);
	}

	@Override
	public Map selectBoardDetail(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.selectBoard(map);
	}

	@Override
	public List selectBoardList(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.selectBoardList(map);
	}

	@Override
	public List<Map> searchBoardList(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.searchBoardList(map);
	}

	@Override
	public int selectBoardCount(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.selectBoardCount(map);
	}
	
	@Override
    public int increaseViewCount(int seq) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.increaseViewCount(seq);
    }
	
	@Override
    public int checkLikeStatus(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.checkLikeStatus(map);
    }

	@Override
	public int addLike(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.addLike(map);
	}

	@Override
	public int cancelLike(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.cancelLike(map);
	}

	@Override
	public int soldout(int seq) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.soldout(seq);
	}
	
	@Override
	public int deleteBoard(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.deleteBoard(map);
	}
	
	@Override
	public int updateBoard(Map map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updateBoard(map);
	}

}
