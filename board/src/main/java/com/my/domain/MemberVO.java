package com.my.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class MemberVO {

	private String mid;
	private String mpw;
	private String mname;
	private String maddress;
	private int mbirth;
	private Date msignupdate;
	private Date mupdatedate;
	private boolean enabled;
	private List<AuthVO> authList;
}
