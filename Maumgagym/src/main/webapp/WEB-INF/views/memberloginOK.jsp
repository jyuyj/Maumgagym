<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.maumgagym.dto.MemberDTO"%>
    
<%
    MemberDTO to1 = (MemberDTO)request.getAttribute( "result" );

    	if( to1.getFlag() == 1  ) {
    		session.setAttribute("id", to1.getId());
    		session.setAttribute("type", to1.getType() );
    		session.setAttribute("nickname", to1.getNickname());
    		
    		out.println( "<script>" );
    		out.println( "alert( '로그인에 성공하셨습니다.' );" );
    		out.println( "location.href='/home';" );
    		out.println( "</script>" );
    	} 
    	else if (to1.getFlag() == 0) {
    		out.println( "<script>" );
    		out.println( "alert('비밀번호가 틀립니다.');" );
    		out.println( "location.href='/member/logout';" );
    		out.println( "</script>" );
    	}
    	else if ( to1.getFlag() == -1 ) {
    		out.println( "<script>" );
    		out.println( "alert('존재하지 않는 아이디입니다.');" );
    		out.println( "location.href='/member/logout';" );
    		out.println( "</script>" );
    	}
    	else if ( to1.getFlag() == -2 ) {
    		out.println( "<script>" );
    		out.println( "alert('테이터베이스 오류 발생');" );
    		out.println( "location.href='/member/logout';" );
    		out.println( "</script>" );
    	}
    %>