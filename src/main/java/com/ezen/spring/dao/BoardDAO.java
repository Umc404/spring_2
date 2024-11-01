package com.ezen.spring.dao;

import java.util.List;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

//	List<BoardVO> getList();

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo);

	int delete(int bno);

	List<BoardVO> getList(PagingVO pgvo);

	int getTotal();

	long getOneBno();

}
