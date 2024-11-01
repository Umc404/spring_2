package com.ezen.spring.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfiguration.class};
		// 'ServletConfig' 명칭의 인터페이스가 이미 존재.(java server에 서비스함.) 명칭을 달리해야함.
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
		// web.xml 에서 루트 경로 설정하는 기능.
	}

	// encoding filter 설정 : web.xml 상단 줄 utf-8 처리 역할
	@Override
	protected Filter[] getServletFilters() {
//		CharacterEncodingFilter encoding = new CharacterEncodingFilter("UTF-8", true);
		// 위 아래 같은 뜻.
		CharacterEncodingFilter encoding = new CharacterEncodingFilter();
		encoding.setEncoding("UTF-8");
		encoding.setForceEncoding(true);
		
		return new Filter[] {encoding};
	}

	// 사용자 지정 설정이 필요한 경우 사용. (파일 업로드)
	@Override
	protected void customizeRegistration(Dynamic registration) {
		// 파일 업로드 설정 (위치 설정)
		String uploadLocation = "D:\\umc\\_myProject\\_java\\_fileUpload";
		int maxFileSize = 1024*1024*20;				// 첨부파일 하나 당 최고 용량 : 20mb
		int maxReqSize = maxFileSize * 3;			// 첨부파일 개수
		int fileSizeThreshold = maxFileSize;		// 
		
		MultipartConfigElement multipartConfig =
				new MultipartConfigElement(uploadLocation, maxFileSize, maxReqSize, fileSizeThreshold);
		
		registration.setMultipartConfig(multipartConfig);
		
		// 기존 사용했던 메서드. 파일업로드 기능 추가 시 사용안함
//		super.customizeRegistration(registration);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
