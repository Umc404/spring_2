package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ezen.spring.dao.BoardDAO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardDAO bdao;

	@Override
	public int insert(BoardVO bvo) {
		// TODO Auto-generated method stub
		return bdao.insert(bvo);
	}

//	@Override
//	public List<BoardVO> getList() {
//		// TODO Auto-generated method stub
//		return bdao.getList();
//	}

	@Override
	public BoardVO getDetail(int bno) {
		// TODO Auto-generated method stub
		return bdao.getDetail(bno);
	}

	@Override
	public int modify(BoardVO bvo) {
		// TODO Auto-generated method stub
		return bdao.modify(bvo);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return bdao.delete(bno);
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getList(pgvo);
	}

	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return bdao.getTotal();
	}
	
}
