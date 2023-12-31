<%@page import="java.io.PrintWriter"%>
<%@page import="com.maumgagym.dto.SearchDTO"%>
<%@page import="com.maumgagym.dao.SearchDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!public void searchList(StringBuilder sb, String title, int seq, String address, int price, String tag, String imageName, String category){
		sb.append("	<div class='col'>");
		sb.append("		<div class='card shadow-sm'>");
		sb.append("			<a href='/facility/" + seq + "'>");
		sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...'></a>");
		sb.append("			<span class='label-top'>" + tag + "</span>");
		sb.append("			<div class='card-body'>");
		sb.append("				<div class='clearfix mb-3'>");
		sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
		sb.append("					<span class='float-end'>");
		sb.append("						<a href='/facility/" + seq + "#review' class='small text-muted'>Reviews</a>");
		sb.append("					</span>");
		sb.append("				</div>");
		sb.append("				<h5 class='card-title'>" + title + "</h5>");
		sb.append("				<span>" + address + "</span>");
		sb.append("				<div class='text-center my-4'>");
		sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
		sb.append("				</div>");
		sb.append("			</div>");
		sb.append("		</div>");
		sb.append("	</div>"); 
	
	}%>	

<%
	request.setCharacterEncoding("utf-8");

		int categorySeq = 0;
		
		String search = null;
		search = (String)request.getAttribute( "data" ); 
		//System.out.println( "검색어 : " + search );
		
		if( request.getParameter( "category_seq" ) != null ) {
			categorySeq = Integer.parseInt( request.getParameter( "category_seq" ) );   // int형 변수 categorySeq에 대입
		}
		//System.out.println("category_seq : " + categorySeq);
		
		ArrayList<SearchDTO> searchLists = (ArrayList<SearchDTO>)request.getAttribute( "list" );
		//System.out.println( "searchLists.size() : " + searchLists.size() );

		StringBuilder sb = new StringBuilder();
		
		for( SearchDTO sto : searchLists ){
			
			String title = sto.getTitle();
			System.out.println( "title : " + title.contains(search) );
			int seq = sto.getB_seq();
			String address = sto.getAddress();
			System.out.println( "address : " + address.contains(search) );
			int price =  sto.getPrice(); 
			String tag = sto.getTag();
			String imageName = sto.getImage_name();
			String category = sto.getTopic();
			System.out.println( "topic : " + category.contains(search) );
			
			System.out.println( "결과 : " + search);
		
			//검색 결과 없을 때
	/*  		if ( ((!title.contains(search)) && (!address.contains(search))) && (!category.contains(search) ) ) {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		pw.println("<script language='javascript'>");
		pw.println("alert('검색 결과가 없습니다.')");
		pw.println("location.href='/home'");
		pw.println("</script>");
		pw.flush();

		break;
			}  */
		
			if( (search != null ) && (categorySeq == 0) ) {
		if( (title.contains(search) || address.contains(search) || category.contains(search) ) ) {
			
			searchList(sb, title, seq, address, price, tag, imageName, category);

		}
			} else if( (search != null ) && (categorySeq != 0 ) ) {
		if( ( categorySeq == sto.getCategory_seq() ) && ( sto.getTitle().contains(search) || sto.getAddress().contains(search) || sto.getTopic().contains(search) ) ) {
		
			searchList(sb, title, seq, address, price, tag, imageName, category);

		}
			}
	 	}
	%>
<hr />

<!-- side navbar -->
<div class="container" style="padding-left: 60px">
	<div class="d-flex">
		<div class="d-flex flex-column flex-shrink-0 p-4">
			<span class="fs-3 pb-3 ">운동시설</span>
			<hr>
			<ul class="nav nav-pill flex-column mb-auto">
				<li class="nav-item ">
					<a id="1" class="nav-link active" aria-current="page">피트니스</a>
				</li>
				<li class="nav-item ">
					<a id="2" class="nav-link active" aria-current="page">요가</a>
				</li>
				<li class="nav-item">
					<a id="3" class="nav-link active " aria-current="page">수영</a>
				</li>
				<li class="nav-item">
					<a id="4" class="nav-link active " aria-current="page">테니스</a>
				</li>
				<li class="nav-item">
					<a id="5" class="nav-link active " aria-current="page">타바타</a>
				</li>
				<li class="nav-item">
					<a id="6" class="nav-link active " aria-current="page">필라테스</a>
				</li>
				<li class="nav-item">
					<a id="7" class="nav-link active " aria-current="page">골프</a>
				</li>
				<li class="nav-item">
					<a id="8" class="nav-link active " aria-current="page">복싱</a>
				</li>
				<li class="nav-item">
					<a id="9" class="nav-link active " aria-current="page">댄스</a>
				</li>
			</ul>
		</div>

		<div class="container">
			<div class="row row-cols-3">
				  <%=sb.toString() %> 
			</div>
		</div>
	</div>
</div>

<script>

$(document).ready(function() {

	$( "li" ).click(function() {
	
		//카테고리 클릭하면 해당 카테고리 번호(id) get
		let categorySeq = $(this).children("a").attr("id");
		
		//현재 url
		const urlStr = window.location.href;  // window.location.href : 현재 페이지 url
		const url =  new URL(urlStr);
		
		//파라미터 객체 생성  => 변경된 페이지 주소 반영
		const urlParams = url.searchParams;
		//객체 로그 확인
		console.log( "urlParams : " + urlParams);
		
		// search 파라미터 확인
		console.log( "search파라미터 : " + urlParams.has( "search") ); 
			
		// search O / category_seq X	  	  ==> 		  카테고리 번호 파라미터 추가
		if( urlParams.has( "search" ) && !( urlParams.has( "category_seq" ) ) ){ 

			urlParams.append( "category_seq", categorySeq );
			location.href = url
			console.log( url );
			
		// search O / category_seq O	  	  ==> 		  카테고리 번호 파라미터 변경
		} else if( urlParams.has( "search" ) && ( urlParams.has( "category_seq" ) ) ) {
			urlParams.set( "category_seq", categorySeq );
			location.href = url; 
			console.log( url );
		}
		
	});
});	
</script>