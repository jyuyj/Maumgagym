package com.maumgagym.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.maumgagym.dao.MypageDAO;
import com.maumgagym.dto.MemberDTO;
import com.maumgagym.dao.BoardDAO;
import com.maumgagym.dao.FacilityDAO;
import com.maumgagym.dto.BoardDTO;
import com.maumgagym.dto.FacilityDTO;

@Controller
public class FacilityController {

	@Autowired
	private FacilityDAO dao;
	private BoardDAO bdao;

	@Autowired
	private MypageDAO mydao;

	// 리스트
	@RequestMapping(value = "/facility", method = RequestMethod.GET)
	public ModelAndView facilityLocList(HttpServletRequest req) {

		String data = null;
		ArrayList<FacilityDTO> facilityLists = dao.facilityList(); // FacilityDAO의 facilityList()를 가져와서 facilityLists라는
																	// 이름의 ArrayList에 넣어줌
		data = req.getParameter("address"); // 클라이언트로부터 받은 address데이터를 data에 대입

		ModelAndView mav = new ModelAndView();
		mav.setViewName("facilityListPage");
		mav.addObject("list", facilityLists);
		mav.addObject("data", data);

		return mav;
	}

	// 지도
	@RequestMapping(value = "/facility/loc", method = RequestMethod.GET)
	public ModelAndView facilityLoc(HttpServletRequest req) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("facilityMapPage");

		return mav;
	}

	// 쓰기
	@RequestMapping(value = "/facility/write", method = RequestMethod.GET)
	public ModelAndView facilityWrite(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("facilityWritePage");

		return mav;
	}

	@RequestMapping(value = "/facility/writeOK", method = RequestMethod.POST)
	public ModelAndView facilityWriteOk(HttpServletRequest req, Model model, MultipartFile upload,
			HttpSession session) {

		ModelAndView mav = new ModelAndView();

		// 1. 사진을 저장합니다.
		String saveFileName = UUID.randomUUID().toString()
				+ upload.getOriginalFilename().substring(upload.getOriginalFilename().indexOf("."));
		try {
			upload.transferTo(new File(saveFileName));
		} catch (IOException e) {
			System.out.println("[에러] :" + e.getMessage());
		}

		// 2. 세션을 통해 얻은 아이디로 member_seq을 가져옵니다. MypageDAO 사용
		MemberDTO mto = new MemberDTO();
		mto.setId((String) session.getAttribute("id"));
		mto = mydao.selectMember(mto);

		// 3. 게시글을 작성합니다.
		FacilityDTO fto = new FacilityDTO();
		fto.setCategory_seq(Integer.parseInt(req.getParameter("category")));
		fto.setTitle(req.getParameter("title"));
		fto.setContent(req.getParameter("content"));
		fto.setWrite_seq(mto.getSeq());
		int flag = dao.insertfacilityBoard(fto);

		// 4. 저장된 게시글의 seq를 가져옵니다.
		fto = dao.selectfacilityBoard(fto);

		int boardSeq = fto.getB_seq();

		// 5. 게시글이 정상적으로 작성이 되었다면, 사진의 정보를 DB에 insert 합니다.
		// 그게 아니라면 500eroor 페이지로 이동시킵니다.
		if (flag == 0) {
			fto.setImage_name(saveFileName);
			fto.setImage_size(upload.getSize());
			flag = dao.insertfacilityImage(fto);
		} else {
			mav.setViewName("error/500error");
			return mav;
		}

		// 6. 사진의 정보를 DB에 정상적으로 insert 했다면, 회원권을 등록합니다.
		// 그게 아니라면 500eroor 페이지로 이동시킵니다.
		if (flag == 0) {

			if (!req.getParameter("membership1").equals("")) {

				fto.setMs_name("1개월권");
				fto.setPrice(Integer.parseInt(req.getParameter("membership1")));
				fto.setPeriod(1);

				flag = dao.insertfacilityMembership(fto);
			}

			if (!req.getParameter("membership3").equals("")) {

				fto.setMs_name("3개월권");
				fto.setPrice(Integer.parseInt(req.getParameter("membership3")));
				fto.setPeriod(3);

				flag = dao.insertfacilityMembership(fto);

			}

			if (!req.getParameter("membership6").equals("")) {

				fto.setMs_name("6개월권");
				fto.setPrice(Integer.parseInt(req.getParameter("membership6")));
				fto.setPeriod(6);

				flag = dao.insertfacilityMembership(fto);
			}

			if (!req.getParameter("membership12").equals("")) {

				fto.setMs_name("12개월권");
				fto.setPrice(Integer.parseInt(req.getParameter("membership12")));
				fto.setPeriod(12);

				flag = dao.insertfacilityMembership(fto);

			}

		} else {
			mav.setViewName("error/500error");
			return mav;
		}

		mav.addObject("flag", flag);
		mav.addObject("board_seq", fto.getB_seq());
		mav.setViewName("facility_writeOkPage");
		return mav;
	}

	/*
	 * //수정
	 * 
	 * @RequestMapping(value="/facility/modify/{seq}", method=RequestMethod.GET)
	 * public ModelAndView facilityModify( HttpServletRequest
	 * request, @PathVariable("seq") int seq ) {
	 * 
	 * ModelAndView mav = new ModelAndView();
	 * 
	 * BoardDTO bto = new BoardDTO(); bto.setSeq(seq); System.out.println(
	 * "controller 글번호 : " + seq ); Map<String, Object> map =
	 * bdao.selectFacilityBoard(bto); map.put( "membershipList",
	 * bdao.selectMemberShips(bto) ); map.put( "noticeList" ,
	 * bdao.selectNotices(bto) ); map.put( "imageList", bdao.selectImages(bto) );
	 * map.put( "reviewList", bdao.selectReviews(bto) );
	 * 
	 * bto = (BoardDTO) map.get( "bto" ); String title = bto.getTitle();
	 * 
	 * 
	 * FacilityDTO fto = new FacilityDTO();
	 * 
	 * fto.setB_seq(seq);
	 * 
	 * System.out.println( "controller 글번호 : " + seq );
	 * 
	 * fto = dao.facilityModify(fto); mav.addObject( "fto", fto );
	 * mav.setViewName("facilityModifyPage");
	 * 
	 * 
	 * mav.addObject("map", map); mav.setViewName("facilityModifyPage");
	 * 
	 * return mav; }
	 */
	
	@RequestMapping(value="/facility/modify", method=RequestMethod.GET)
	public String facilitymodify(int seq, Model model){ 

		FacilityDTO fto = new FacilityDTO();
		fto.setB_seq(seq);
		 
		System.out.println( "controller 글번호 : " + seq );
		
		fto = dao.facilityModify(fto);
		model.addAttribute("fto", fto);
		
		return "facilityModifyPage";
	}
}