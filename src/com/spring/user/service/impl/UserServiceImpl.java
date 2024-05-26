package com.spring.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserDao userDao;
	
	@Override
	public int userSignUp(UserVo userVo) {
		return userDao.userSignUp(userVo);
	}

	@Override
	public int checkUserId(String userId) {
		return userDao.checkUserId(userId);
	}
	
	@Override
	public List<UserVo> selectUsers() {
		return userDao.selectUsers();
	}

	@Override
	public UserVo loginUserId(UserVo userVo) {
		return userDao.loginUserId(userVo);
	}

}
