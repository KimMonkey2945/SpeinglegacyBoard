package com.spring.user.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImple implements UserDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int userSignUp(UserVo userVo) {
		return sqlSession.insert("user.userSignUp", userVo);
	}


	@Override
	public int checkUserId(String userId) {
		return sqlSession.selectOne("user.checkUserId", userId);
	}
	
	@Override
	public List<UserVo> selectUsers() {
		return sqlSession.selectList("user.selectUsers");
	}


	@Override
	public  UserVo loginUserId(UserVo userVo) {
		return sqlSession.selectOne("user.loginUserId", userVo);
	}


}
