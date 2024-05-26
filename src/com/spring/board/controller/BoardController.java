package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardFilterRequest;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, BoardVo boardVo, CodeVo codeVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		codeVo.setCodeType("menu");
		codeList = boardService.selectCodeType(codeVo);
		totalCnt = boardService.selectBoardCnt();	
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageVo.getPageNo());
		model.addAttribute("board", boardVo);
		model.addAttribute("code", codeList);
		
		/*
		 * for(CodeVo a : codeList) { System.out.println("codeVo.getCodeType() : " +
		 * a.getCodeType());
		 * 
		 * }
		 */
		
//		System.out.println(pageVo.getPageNo()); 숫자는 잘찍힘.
		
		return "board/boardList";
		
	}
	

	@RequestMapping(value = "/board/filteredBoardList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> filterBoardList(@RequestBody BoardFilterRequest request) throws Exception {
	    List<String> boardTypes = request.getBoardTypes();
	    int pageNo = request.getPageNo();
	    
	    // Debugging information
	    System.out.println("Received boardTypes: " + boardTypes);
	    System.out.println("Received pageNo: " + pageNo);

	    int page = 1;
	    if (pageNo == 0) {
	        pageNo = page;
	    }
	    
	    PageVo pageVo = new PageVo();
	    pageVo.setPageNo(pageNo);
	    
	    List<BoardVo> boardList = boardService.filterBoardList(boardTypes, pageVo);
	    int totalCnt = boardService.selectFilteredBoardCnt(boardTypes);

	    Map<String, Object> response = new HashMap<>();
	    response.put("boardList", boardList);
	    response.put("totalCnt", totalCnt);
	    
	    // Debugging information
	    System.out.println("Returning response: " + response);
	    
	    return response;
	}


	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum, PageVo pageVo, BoardVo boardVo) throws Exception{
		
		/* BoardVo boardVo = new BoardVo(); */
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("pageNo", pageVo.getPageNo());
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, BoardVo boardVo, CodeVo codeVo) throws Exception{
		int boardNum = boardService.boardNum();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		codeVo.setCodeType("menu");
		codeList = boardService.selectCodeType(codeVo);
		model.addAttribute("boardNum", boardNum + 1);
		model.addAttribute("code", codeList);
		System.out.println("boardNum : "+ boardNum);
		return "board/boardWrite";
	}
	
	/* 하나로 통일 가능.
	 * @RequestMapping(value = "/board/boardWriteAction.do", method =
	 * RequestMethod.POST)
	 * 
	 * @ResponseBody public String boardWriteAction(Locale locale,BoardVo boardVo)
	 * throws Exception{
	 * 
	 * HashMap<String, String> result = new HashMap<String, String>(); CommonUtil
	 * commonUtil = new CommonUtil();
	 * 
	 * int resultCnt = boardService.boardInsert(boardVo); String page = "1";
	 * 
	 * result.put("success", (resultCnt > 0)?"Y":"N"); // 수정한 부분
	 * result.put("pageNo", page);
	 * 
	 * String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
	 * 
	 * System.out.println("callbackMsg::"+callbackMsg);
	 * 
	 * return callbackMsg; }
	 */
	
	
	//version2
	@RequestMapping(value = "/board/manyBoardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String manyBoardWriteAction(@RequestBody List<Map<String, Object>> paramMap) throws Exception {
	    
	    ObjectMapper mapper = new ObjectMapper();
	    List<BoardVo> boardList = new ArrayList<>();


	    HashMap<String, String> result = new HashMap<>();
	    CommonUtil commonUtil = new CommonUtil();
	    int resultCnt = 0;

	    for (Map<String, Object> map : paramMap) {
//	        System.out.println("Map: " + map);
	        BoardVo board = mapper.convertValue(map, BoardVo.class);
	        boardList.add(board);
	        boardService.boardInsert(board);
	        System.out.println("BoardType  " + board.getBoardType()); 
	        resultCnt++;
	    }

	    String page = "1";
	    result.put("success", (resultCnt == boardList.size()) ? "Y" : "N");
	    result.put("pageNo", page);

	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    System.out.println("callbackMsg::" + callbackMsg);

	    return callbackMsg;
	}
	
	// update
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdateView.do", method = RequestMethod.GET)
	public String boardUpdateView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum
			,CodeVo codeVo) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		boardVo = boardService.selectBoard(boardType,boardNum);
		codeVo.setCodeType("menu");
		codeList = boardService.selectCodeType(codeVo);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("code", codeList);
		
		
		return "board/boardUpdateView";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/{updateBoardType}/boardUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(@PathVariable("updateBoardType")String updateBoardType, BoardVo boardVo, PageVo pageNo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		boardVo.setUpdateBoardType(updateBoardType);
		
		int resultCnt = boardService.boardUpdate(boardVo);
		result.put("success", (resultCnt > 0)?"Y":"N");
		// 수정한 부분
		result.put("pageNo",  String.valueOf(pageNo.getPageNo()));
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale, BoardVo boardVo, Model model, PageVo pageVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);


		result.put("success", (resultCnt > 0)?"Y":"N");
		// 수정한 부분
		result.put("resultCnt",  String.valueOf(resultCnt));
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	
	}
	
}
