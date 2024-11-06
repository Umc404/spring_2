package com.ezen.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.CommentVO;
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

	int update(BoardVO bvo);

	int plusCmt(CommentVO cvo);

	int minusCmt(CommentVO cvo);

	void hasFileUpdate(@Param("bno") long oneBno, @Param("cnt") int size);

	void readCountUp(int bno);

}
