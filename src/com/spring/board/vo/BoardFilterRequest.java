package com.spring.board.vo;

import java.util.List;

public class BoardFilterRequest {
	
	 private List<String> boardTypes;
	    private int pageNo;

	    // getters and setters
	    public List<String> getBoardTypes() {
	        return boardTypes;
	    }

	    public void setBoardTypes(List<String> boardTypes) {
	        this.boardTypes = boardTypes;
	    }

	    public int getPageNo() {
	        return pageNo;
	    }

	    public void setPageNo(int pageNo) {
	        this.pageNo = pageNo;
	    }
	
}
