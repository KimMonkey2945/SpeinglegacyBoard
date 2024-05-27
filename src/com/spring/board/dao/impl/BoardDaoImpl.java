package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}

	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public List<BoardVo> filteredBoardList(List<String> boardTypes, PageVo pageVo) {
		Map<String, Object> params = new HashMap<>();
		params.put("boardTypes", boardTypes);
        params.put("pageVo", pageVo);
        return sqlSession.selectList("board.filteredBoardList", params);
	}
	
	@Override
	public int selectFilteredBoardCnt(List<String> boardTypes) {
		Map<String, Object> params = new HashMap<>();
		params.put("boardTypes", boardTypes);
		return sqlSession.selectOne("board.selectFilteredBoardCnt", params);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) {
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public int delete(BoardVo boardVo) {
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public int boardNum() {
		return sqlSession.selectOne("board.boardNum");
	}
	@Override
	public List<CodeVo> selectCodeType(CodeVo codeVo) {
		return sqlSession.selectList("board.selectCodeType" , codeVo);
	}

	
	
}
