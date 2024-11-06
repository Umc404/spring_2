package com.ezen.spring.dao;

import java.util.List;

import com.ezen.spring.domain.FileVO;

public interface FileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getList(int bno);

	int modifyFile(FileVO fvo);

	int removeFile(String uuid);

	List<FileVO> selectListAllFile();

	long getBnoToUuid(String uuid);

}
