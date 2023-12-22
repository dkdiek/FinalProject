package com.tjoeun.ilsan.board.free.reply.service;

import java.util.List;
import java.util.Map;

public interface FreeBoardRepService {
	
	public void insert(Map map) throws Exception;

	public List<Map> select(Map map);


}
