package com.ezen.spring.service;

import java.util.List;

import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardService {

//	int insert(BoardVO bvo);

//	List<BoardVO> getList();

	BoardDTO getDetail(int bno);

	int modify(BoardVO bvo);

	int delete(int bno);

	List<BoardVO> getList(PagingVO pgvo);

	int getTotal();

	int insert(BoardDTO bdto);
	
}
