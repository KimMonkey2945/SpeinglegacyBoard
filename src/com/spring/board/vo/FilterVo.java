package com.spring.board.vo;

import java.util.List;

public class FilterVo {

	private List<String> boardTypes;
	private PageVo pageVo;

    public List<String> getBoardTypes() {
        return boardTypes;
    }

    public void setBoardTypes(List<String> boardTypes) {
        this.boardTypes = boardTypes;
    }

	public PageVo getPageVo() {
		return pageVo;
	}

	public void setPageVo(PageVo pageVo) {
		this.pageVo = pageVo;
	}
    
    
	
}
