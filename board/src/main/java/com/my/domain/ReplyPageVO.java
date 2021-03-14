package com.my.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
public class ReplyPageVO {

	private int replyCnt;
	private List<ReplyVO> list;
	
} //end of ReplyPageVO
