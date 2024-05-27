package com.spring.user.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.service.BoardService;
import com.spring.board.vo.CodeVo;
import com.spring.common.CommonUtil;
import com.spring.session.SessionConst;
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

		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

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
	public Map<String, Object> loginAction(@RequestBody UserVo userVo, HttpServletRequest request) throws IOException {

		HashMap<String, Object> result = new HashMap();
		UserVo user = userService.loginUserId(userVo);
		
        if (user == null) {
            result.put("nullId", "존재하지 않는 아이디입니다.");
        } else if (!user.getUserPw().equals(userVo.getUserPw())) {
            result.put("nullPassword", "비밀번호를 정확히 입력해주세요.");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute(SessionConst.LOGIN_MEMBER, user);
            System.out.println("로그인한 사용자: " + session.getAttribute(SessionConst.LOGIN_MEMBER));
        }
		 
		 
		return result;

	}
	
	@RequestMapping(value = "/user/logoutAction.do", method = RequestMethod.GET)
	 public String logoutAction(HttpServletRequest request) {
		 // 세션을 비워 로그아웃 처리
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }
        // 로그아웃 후에는 메인 화면으로 리다이렉트
        return "redirect:/board/boardList.do";
	}

}
