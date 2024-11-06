package com.ezen.spring.service;

import java.util.List;

import com.ezen.spring.domain.UserVO;

public interface UserService {

	int register(UserVO uvo);

	List<UserVO> getList();

	int modifyPwdEmpty(UserVO uvo);

	int modify(UserVO uvo);

	int remove(String email);

}
