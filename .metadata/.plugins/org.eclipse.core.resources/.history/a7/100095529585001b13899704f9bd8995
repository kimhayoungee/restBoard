package com.my.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageVO(int total, Criteria cri) {
		super();
		this.total = total;
		this.cri = cri;
		
		this.endPage = ((cri.getPageNum()/10) +1) *10;
		this.startPage = this.endPage -9;
		
		int realEndPage = (total / cri.getAmount()) +1;
		
		if(realEndPage <this.endPage) this.endPage = realEndPage;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEndPage;
	}
	
}
