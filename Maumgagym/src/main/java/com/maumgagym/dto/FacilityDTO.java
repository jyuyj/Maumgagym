package com.maumgagym.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FacilityDTO {

	//board
	int b_seq;
	int category_seq;
	String title;
	String content;
	int write_seq;
	String write_date;
	int status;
	
	//member
	int m_seq;
	String address;
	String id;
	String name;
	
	//membership
	int price;
	String ms_name;
	int period;
	
	//tag
	String tag;
	
	//image
	String image_name;
	double image_size;
	
	
}
