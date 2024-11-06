package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ezen.spring.dao.UserDAO;
import com.ezen.spring.domain.UserVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {
	
	private final UserDAO udao;
	
	@Transactional
	@Override
	public int register(UserVO uvo) {
		int isOk = udao.insert(uvo);
		
		return udao.insertAuthInit(uvo);
	}

	@Override
	public List<UserVO> getList() {
		// TODO Auto-generated method stub
		return udao.getList();
	}

	@Override
	public int modifyPwdEmpty(UserVO uvo) {
		// TODO Auto-generated method stub
		return udao.modifyPwdEmpty(uvo);
	}

	@Override
	public int modify(UserVO uvo) {
		// TODO Auto-generated method stub
		return udao.modify(uvo);
	}

	@Override
	public int remove(String email) {
		// TODO Auto-generated method stub
		return udao.remove(email);
	}
	
	// remove 할때 transactional annotation 처리 후 auth쪽도 삭제
	// udao.removeAuth(email) 부터 int 선언 처리 후 return에서 board table del
}
