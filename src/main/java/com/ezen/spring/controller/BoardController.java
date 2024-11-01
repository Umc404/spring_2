package com.ezen.spring.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.FileVO;
import com.ezen.spring.domain.PagingVO;
import com.ezen.spring.handler.FileHandler;
import com.ezen.spring.handler.PagingHandler;
import com.ezen.spring.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
@Controller
public class BoardController {
	/* 생성자 주입 시 객체는 final 로 생성 */
	
	private final BoardService bsv;
	private final FileHandler fh;
	
	// return void => 온 경로 그대로 리턴 /board/register => /board/register.jsp
	@GetMapping("/register")
	public void register() {}
	
	
	// 첨부파일 => multipartFile	/	여러개.. multipartFile[]
	@PostMapping("/insert")
	public String insert(BoardVO bvo, MultipartFile[] files) {
		log.info(">>> insert bvo > {}",bvo);
		List<FileVO> flist = null;
		
		if(files[0].getSize() > 0) {
			// 파일에 내용이 있다면 처리
			flist = fh.uploadFiles(files);
			log.info(">>>> flist > {}", flist);
		}
		
		// files 정보를 이용하여 => List<FileVO> 변환을 하는 핸들러
		// fileHandler => return List<FileVO> + 파일 저장
		
		BoardDTO bdto = new BoardDTO(bvo, flist);
		int isOk = bsv.insert(bdto);
//		int isOk = bsv.insert(bvo);
//		log.info(">>> insert > {}", isOk>0? "OK":"Fail");
		
		// /WEB-INF/views/.jsp (X)
		// 컨트롤러의 mapping 위치로 연결할 때 redirect:/board/list
		
		return "redirect:/";
	}
	
//	@GetMapping("/list")
//	public String list(Model m) {
//		// request.setAttribute()
//		// Model 객체가 해당 일을 대신해 줌.
//		List<BoardVO> list = bsv.list();
//		m.addAttribute("list", list);
//		return "/board/list";
//	}
	
	@GetMapping("/list")
	public String list(Model m, PagingVO pgvo) {
		//request.setAttrbute()  
		//Model 객체가 해당 일을 대신해 줌.
//		PagingVO pgvo = new PagingVO();
		List<BoardVO> list = bsv.getList(pgvo);
		// totalCount를 구해서 PagingHadler에 매개변수로 전달
		int totalCount = bsv.getTotal();
		PagingHandler ph = new PagingHandler(totalCount, pgvo);
		log.info(">>> totalCount > {}", totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
		return "/board/list";
	}
	// @requestParam("bno") int bno  => 전달되는 파라미터가 여러개일 경우 이름을 명시
		// return void : 요청 경로로 응답을 그대로 보냄.  /board/detail => /board/detail.jsp 
		@GetMapping({"/detail", "/modify"})
		public void detail(int bno, Model m) {
			// bno에 해당하는 BoardVO 객체를 DB에서 가져와서 모델로 전달
			BoardDTO bdto = bsv.getDetail(bno);
			m.addAttribute("bdto", bdto);			
			
//			BoardVO bvo = bsv.getDetail(bno);
//			m.addAttribute("bvo", bvo);
//			return "/board/detail";
		}
		
		@PostMapping("/update")
		public String update(BoardVO bvo) {
			
			int isOk = bsv.modify(bvo);
			log.info(">>>> update > {}", isOk>0? "OK": "Fail");
			
			//detail.jsp로 이동 X  => controller detail mapping으로 이동  => redirect:/
			return "redirect:/board/detail?bno="+bvo.getBno();
		}
		
		@GetMapping("/delete")
		public String delete(int bno) {
			int isOk = bsv.delete(bno);
			log.info(">>>> delete > {}", isOk>0? "OK": "Fail");
			return "redirect:/board/list";
		}
	
}
