package com.my.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public Criteria() {
		this(1,10);
	}
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
	
	public String getListLink() {
		
		UriComponentsBuilder ub = UriComponentsBuilder.fromPath("").queryParam("pageNum", this.pageNum)
																   .queryParam("amount", this.getAmount())
																   .queryParam("type", this.getType())
																   .queryParam("keyword", this.getKeyword());
		                
		return ub.toUriString();
	}
}
