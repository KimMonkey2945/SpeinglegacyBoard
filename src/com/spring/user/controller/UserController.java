package com.spring.user.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.service.BoardService;
import com.spring.board.vo.CodeVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Controller
public class UserController {
	
	@Autowired 
	UserService userService;
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/user/signUpForm.do", method = RequestMethod.GET)
	public String signUpFrom(CodeVo codeVo, Model model) {
		
		codeVo.setCodeType("phone");
		List<CodeVo> codeList = new ArrayList<>();
		codeList = boardService.selectCodeType(codeVo);
		
		model.addAttribute("codeList", codeList);
		
		return "user/signUp";
	}
	
	@RequestMapping(value = "/user/signUpAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String signUpAction(UserVo userVo) throws IOException {
		
		HashMap<String, String> result = new HashMap();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = 0;
		
		resultCnt = userService.userSignUp(userVo);
		
		result.put("success", (resultCnt > 0) ? "Y":"N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg:: " + callbackMsg);
		 
		return callbackMsg;
		
	}
	
	@RequestMapping(value = "/user/checkUserId.do", method = RequestMethod.POST)
	@ResponseBody
	public int checkUserId(@RequestParam("userId") String userId) {
		return userService.checkUserId(userId);
	}
	
	@RequestMapping(value = "/user/loginForm.do", method = RequestMethod.GET)
	public String loginFrom(CodeVo codeVo, Model model) {
		
		return "user/loginForm";
	}
	
	@RequestMapping(value = "/user/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loginAction(@RequestBody UserVo userVo) throws IOException {
		
		HashMap<String, Object> result = new HashMap();
		UserVo user = userService.loginUserId(userVo);
		
		 System.out.println("Received userVo: " + userVo.getUserId() + ", " + userVo.getUserPw());
		
		System.out.println("user : " + user);
		
		if(user == null) {
			result.put("nullId", "존재하지 않는 아이디입니다.");
		}else {
			if(!user.getUserPw().equals(userVo.getUserPw())) {
				result.put("nullPassword", "비밀번호를 정확히 입력해주세요.");
			}			
		}
		
		return result; 
		
	}
	
	

}
