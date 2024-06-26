package com.spring.user.dao;

import java.util.List;

import com.spring.user.vo.UserVo;

public interface UserDao {

	public int userSignUp(UserVo userVo);

	public int checkUserId(String userId);
	
	public List<UserVo> selectUsers();

	public UserVo loginUserId(UserVo userVo);

}
