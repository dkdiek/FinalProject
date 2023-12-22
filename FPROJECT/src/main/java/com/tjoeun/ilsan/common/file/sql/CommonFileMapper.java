package com.tjoeun.ilsan.common.file.sql;

import java.util.List;
import java.util.Map;

public interface CommonFileMapper {
	
	public int insert(Map map);
	
	public List<Map> select(Map map);

}
