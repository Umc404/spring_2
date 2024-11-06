package com.ezen.spring.handler;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ezen.spring.dao.FileDAO;
import com.ezen.spring.domain.FileVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


// 매일 정해진 시간에 스케쥴러를 실행
// 매일 등록된 파일과 (DB) <-> 해당 일자의 폴더에 있는 파일이 일치하는 파일은 남겨놓고,
// 일치하지 않는 파일은 삭제.
// +) 현재 파일 업로드 테스트가 다수 발생하여 해당 경로에 저장된 파일들이 다수 있음.
//    삭제된 게시판 내 첨부된 파일들은 삭제처리해야함.
// file.delete() - fileRemoveHandler 를 사용하여 삭제해도 무방함.
// pom.xml 에 스케쥴러 관련 디펜던시 추가 : quartz, quartz-jobs

@Slf4j
@RequiredArgsConstructor				// 추가 안하면 'private final FileDAO fdao;' 오류. 값을 가져오는 역할.
@Component
@EnableScheduling
public class FileSweeper {
	// 직접 DB 접속해서 처리
	private final FileDAO fdao;
	private final String BASE_PATH = "D:\\umc\\_myProject\\_java\\_fileUpload\\";
	
	
	// 스케쥴 기록 cron 방식 : 초 분 시 일 월 연도(생략 가능) 
	// (cron = "59 59 23 * * *") : 매일 23시 59분 59초에 실행
	@Scheduled(cron="00 53 14 * * *")
	public void fileSweeper() {
		log.info(">>>> FileSweeper Running Start. : {}",LocalDateTime.now());
		// 처리
		
		// db에 등록된 모든 파일 목록을 가져오기
		List<FileVO> dbList = fdao.selectListAllFile();
		
		// D:\\umc\\_myProject\\_java\\_fileUpload\\2024\\11\\04\\uuid_파일명
		// D:\\umc\\_myProject\\_java\\_fileUpload\\2024\\11\\04\\uuid_th_파일명 => 이미지만 존재
		
		// 파일 경로와 파일명을 붙인 실제 존재해야하는 파일리스트
		List<String> currFiles = new ArrayList<String>();
		for(FileVO fvo : dbList) {
			String filePath = fvo.getSaveDir()+File.separator+fvo.getUuid();
			String fileName = fvo.getFileName();
			currFiles.add(BASE_PATH + filePath + "_" + fileName);
			
			// 이미지라면 썸네일 경로도 추가. fileType이 이미지면 1로 처리.
			if(fvo.getFileType() > 0) {
				currFiles.add(BASE_PATH + filePath + "_th_" + fileName);
			}
			
			log.info(">>>> currFiles >> {}", currFiles);
			
			// 실제 파일경로를 설정
			LocalDate now = LocalDate.now();
			String today = now.toString();
			today = today.replace("-", File.separator);
			
			// 경로를 기반으로 저장되어 있는 파일을 검색
			// D:\_myProject\_java_\fileUpload\2024\11\04
			File dir = Paths.get(BASE_PATH+today).toFile();
			// listFiles() : 경로 안에 있는 모든 파일을 배열로 리턴
			File[] allFileObject = dir.listFiles();
			log.info(">>>> all file Object >> {}", allFileObject.toString());
			
			// 실제 저장되어있는 파일목록과, DB의 존재 파일을 비교하여 DB에 있는 파일은 삭제 진행.
			for(File file : allFileObject) {
				String storedFileName = file.toPath().toString();
				if(!currFiles.contains(storedFileName)) {
					file.delete();		// 파일 삭제
					log.info(">>>> delete files >> {}", storedFileName);
				}
			}
		}
		
		
		log.info(">>>> FileSweeper Running End. : {}",LocalDateTime.now());
	}
	
	
	
}
