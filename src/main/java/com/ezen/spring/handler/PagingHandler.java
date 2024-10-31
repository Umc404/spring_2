package com.ezen.spring.handler;

import java.util.List;

import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {
	
	private int qty; //한 페이지에 나오는 페이지네이션 개수 : 10개
	private int startPage; //한 페이지에 나오는 페이지네이션 시작번호 : 1  11  21  ... 181
	private int endPage; //한 페이지에 나오는 페이지네이션 끝번호 : 10  20  30  ....   181
	private boolean prev;
	private boolean next;
	
	private int totalCount; //전체 페이지 수 : DB에서 조회해 와야 하는 값. (매개변수로 받아오기)
	private PagingVO pgvo; //현재 페이지 번호 : pagingVO pageNo  사용 (매개변수로 받아오기)
	
	private int realEndPage;
	
	private List<CommentVO> cmtList;
	
	// 생성자에서 모든 값들이 계산되어 설정되어야 함.
	public PagingHandler(int totalCount, PagingVO pgvo) {
		this.qty = 10;
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		// 1~10 / 11~20 / 21~30 ....
		// pageNo => 1 2 3 .. 10  => 1~10
		// pageNo => 11 12 13 ... 20  => 11~20
		// 1 2 3 ... 10  => 10 endPage는 변함없이 10
		// 11 12 13 ... 20  => 20
		
		// 1 / 10개  => 0.1 결과를 올림 => 1 * 10  => 10
		// 11 / 10  => 1.1 결과를 올림(ceil) => 2 * 10  => 20
		// 정수 / 정수 => 정수  형변환을 해서 소수점을 유지
		this.endPage = (int)Math.ceil(pgvo.getPageNo() / (double)qty) * qty;
		this.startPage = endPage - 9; 
		
		// 실제 마지막 페이지
		// 전체 글수 / 한페이지에 표시되는 게시글 수 (올림)
		// 11 / 10  => 2페이지  1.1 (올림) => 2
		this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
		
		// 이전, 다음 여부
		this.prev = this.startPage > 1; // 1  11  21  31
		this.next = this.endPage < this.realEndPage;
		
		if(endPage > realEndPage) {
			this.endPage = realEndPage;
		}
		
	}
	
	// 댓글용
	public PagingHandler(int totalCount, PagingVO pgvo, List<CommentVO> cmtList) {
		this(totalCount, pgvo);
		this.cmtList = cmtList;
	}
}
