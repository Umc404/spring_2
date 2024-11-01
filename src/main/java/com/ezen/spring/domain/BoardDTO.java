package com.ezen.spring.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// Data Transfer Object

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	
	private BoardVO bvo;
	private List<FileVO> flist;				// jsp 에서 선언 객체명에 두번째 글자가 대문자면 오류남. flist(o) fList(x). 그런데 fileList 는 됨.
}
