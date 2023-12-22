package com.tjoeun.ilsan.common.file.dao;

import java.util.List;
import java.util.Map;

public interface CommonFileDao {

	public int insert(Map map);
	
	public List<Map> select(Map map);

}
