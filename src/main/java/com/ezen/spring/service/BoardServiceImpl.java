package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.dao.BoardDAO;
import com.ezen.spring.dao.FileDAO;
import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.FileVO;
import com.ezen.spring.domain.PagingVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardDAO bdao;
	private final FileDAO fdao;
	
//	@Override
//	public int insert(BoardVO bvo) {
//		// TODO Auto-generated method stub
//		return bdao.insert(bvo);
//	}

//	@Override
//	public List<BoardVO> getList() {
//		// TODO Auto-generated method stub
//		return bdao.getList();
//	}

//	@Override
//	public BoardVO getDetail(int bno) {
//		// TODO Auto-generated method stub
//		return bdao.getDetail(bno);
//	}

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

	@Override
	public int insert(BoardDTO bdto) {
		// bvo + file
		// bvo 먼저 insert 하고 난 후 bno를 DB에서 빼와야 함. > fvo를 DB에 저장
		int isOk = bdao.insert(bdto.getBvo());
		if(bdto.getFlist() == null) {
			return isOk;
		}
		
		// 첨부파일이 있는 케이스
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			// bno setting
			long bno = bdao.getOneBno();	// 가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isOk *= fdao.insertFile(fvo);
			}
		}
		
		return 0;
	}
	
	
	@Override
	@Transactional
	public BoardDTO getDetail(int bno) {
		// bdao > bvo	/ fado > fvo 묶어서 BoardDTO로 리턴
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getList(bno);
		
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}
	
}
