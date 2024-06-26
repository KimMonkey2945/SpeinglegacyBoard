package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;

public interface BoardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo);

	public int boardDelete(BoardVo boardVo);

	public int boardNum();

	public List<BoardVo> filterBoardList(List<String> boardTypes, PageVo pageVo);

	public int selectFilteredBoardCnt(List<String> boardTypes);

	public List<CodeVo> selectCodeType(CodeVo codeVo);

}
