package com.maumgagym.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.ReviewDAO;
import com.maumgagym.dto.BoardDTO;
import com.maumgagym.dto.MemberDTO;
import com.maumgagym.dto.PayDTO;
import com.maumgagym.dto.ReviewDTO;


@Controller
public class ReviewController {
	
	@Autowired
	private ReviewDAO dao;
	
	@ResponseBody
	@RequestMapping( value = "/review/write", method = RequestMethod.POST )
	public HashMap<String, Object> insertReview( HttpServletRequest request ) { 
		
		ReviewDTO rvto = new ReviewDTO();
		
		rvto.setMerchant_uid( request.getParameter( "merchant_uid" ) );
		rvto.setContent( request.getParameter( "content" ) );
		rvto.setWriter_seq( Integer.valueOf( request.getParameter( "writer_seq" ) ) );
		rvto.setStar_score( Float.parseFloat( request.getParameter( "star_score" ) ) );
		rvto.setBoard_seq( Integer.valueOf( request.getParameter( "board_seq" ) ) ); 
		
		rvto = dao.insertReview(rvto);
		
		int flag = 9;
		if( rvto.getFlag() == 0 ) {
			MemberDTO mto = new MemberDTO();
			BoardDTO bto = new BoardDTO();
			mto.setSeq( rvto.getWriter_seq() );
			bto.setSeq( rvto.getBoard_seq() );
			flag = dao.InsertNews(mto, bto );
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put( "flag", flag );
		map.put( "merchant_uid", rvto.getMerchant_uid() );
		
		return map;
	}
}
