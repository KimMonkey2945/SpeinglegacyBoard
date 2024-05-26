package com.spring.user.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.user.vo.UserVo;

public interface UserService {
	
	
	public int userSignUp(UserVo userVo);

	public int checkUserId(String userId);
	
	public List<UserVo> selectUsers();

	public UserVo loginUserId(UserVo userVo);

	
	

}
