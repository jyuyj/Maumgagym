package com.maumgagym.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.SearchDAO;
import com.maumgagym.dto.SearchDTO;


@Controller
public class SearchController {
	
	@Autowired
	private SearchDAO dao;
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchList( HttpServletRequest req) {
		
		String data = null;
		ArrayList<SearchDTO> searchLists = dao.searchResult();
		data = req.getParameter( "search" );
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "searchPage" );
		mav.addObject( "list", searchLists  );
		mav.addObject( "data", data );
		
		return mav;
	}
}
