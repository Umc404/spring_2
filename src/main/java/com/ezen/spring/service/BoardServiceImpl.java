package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.dao.BoardDAO;
import com.ezen.spring.dao.FileDAO;
import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.CommentVO;
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

	@Transactional
	@Override
	public int modify(BoardDTO bdto) {
		int isOk = bdao.update(bdto.getBvo());
		if(bdto.getFlist() == null) {
			return isOk;
		}
		
		// 첨부파일이 있는 케이스
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			// bno setting
//			long bno = bdao.getOneBno();	// 가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bdto.getBvo().getBno());
				isOk *= fdao.insertFile(fvo);
			}
		}
		bdao.hasFileUpdate(bdto.getBvo().getBno(), bdto.getFlist().size());
		return isOk;
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
		bdao.hasFileUpdate(bdto.getBvo().getBno(), bdto.getFlist().size());
		return isOk;
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

	@Override
	public int removeFile(String uuid) {
		long bno = fdao.getBnoToUuid(uuid);
		int isOk = fdao.removeFile(uuid);
		if(isOk > 0) {
			bdao.hasFileUpdate(bno, -1);
		}
		return isOk;
	}

	@Override
	public int plusCmt(CommentVO cvo) {
		// TODO Auto-generated method stub
		return bdao.plusCmt(cvo);
	}

	@Override
	public int minusCmt(CommentVO cvo) {
		return bdao.minusCmt(cvo);
	}

	@Override
	public void readCountUp(int bno) {
		// TODO Auto-generated method stub
		bdao.readCountUp(bno);
	}

}
