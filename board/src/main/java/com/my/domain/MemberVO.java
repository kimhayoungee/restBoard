package com.my.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	/*
	 * private String mid; private String mpw; private String mname; private String
	 * maddress; private int mbirth; private Date msignupdate; private String
	 * mdeleteyn;
	 */
	private Integer mno;
	private String firstName;
	private String lastName;
}
