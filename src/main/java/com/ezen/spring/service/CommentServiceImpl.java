package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ezen.spring.dao.CommentDAO;
import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;
import com.ezen.spring.handler.PagingHandler;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// @RequiredArgsConstructor 선언하지 않으면 CommentDAO cdao는 맹탕이라 final 선언이 어려움
// final 선언 이유 : 외부 파괴적 선언 시 변환하지 않도록 사전처리. = 알박기

@RequiredArgsConstructor
@Service
@Slf4j
public class CommentServiceImpl implements CommentService {
	
	private final CommentDAO cdao;

	@Override
	public int post(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.post(cvo);
	}

//	@Override
//	public List<CommentVO> getList(long bno) {
//		// TODO Auto-generated method stub
//		return cdao.getList(bno);
//	}

	@Override
	public int modify(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.modify(cvo);
	}

	@Override
	public int delete(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.delete(cvo);
	}

	@Override
	public PagingHandler getList(long bno, PagingVO pgvo) {
		// ph 객체 안에 cmtList / totalCount 구해오기
		List<CommentVO> cmtList = cdao.getList(bno, pgvo);
		int totalCount = cdao.getTotalCount(bno);
		PagingHandler ph = new PagingHandler(totalCount, pgvo, cmtList);
		return ph;
	}
	
	
}
