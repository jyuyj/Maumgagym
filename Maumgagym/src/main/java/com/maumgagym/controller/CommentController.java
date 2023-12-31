package com.maumgagym.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.CommentDAO;
import com.maumgagym.dto.BoardDTO;
import com.maumgagym.dto.CommentDTO;
import com.maumgagym.dto.MemberDTO;


@Controller
public class CommentController {
	
	@Autowired
	private CommentDAO dao;

	@ResponseBody
	@RequestMapping( value = "/comment/write", method = RequestMethod.POST )
	public int addComment( HttpServletRequest request ) { 
		
		CommentDTO cto = new CommentDTO();
		MemberDTO mto = new MemberDTO();
		BoardDTO bto = new BoardDTO();
		
		cto.setContent( request.getParameter( "comments" ));
		mto.setNickname( request.getParameter("cmt_nickname"));
		cto.setBoard_seq(Integer.parseInt(request.getParameter("board_seq")));
		
		
		int flag = dao.commentInsert(cto, mto);
		
		return flag;
	}
	
	@ResponseBody
	@RequestMapping( value = "/comment/delete")
	public int deleteComment( HttpServletRequest request ) { 
		
		int cmtseq = Integer.parseInt(request.getParameter("cmtseq"));
		System.out.println(cmtseq);
		int flag = dao.commentDelete(cmtseq);
		System.out.println(flag);
		
		return flag;
	}
	
}