<%@page import="com.maumgagym.dto.FacilityDTO"%>
<%@page import="com.maumgagym.dto.MemberShipDTO"%>
<%@page import="com.maumgagym.dto.MemberDTO"%>
<%@page import="com.maumgagym.dto.BoardDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		
<%
 	request.setCharacterEncoding("utf-8");
	
	// 리스트 출력
	ArrayList<FacilityDTO> list = (ArrayList<FacilityDTO>) request.getAttribute("list");
	
	String data = null;
	String[] dongAddr = null;
	String fullDongAddr = null;
	int categorySeq = 0;

	if( request.getAttribute( "data" ) == null ) {
		fullDongAddr = "위치를 지정해 주세요.";
	} else {
		data = (String)request.getAttribute( "data" );
		dongAddr = data.split(" ");
		
		fullDongAddr = String.format( "%s %s %s", dongAddr[0], dongAddr[1], dongAddr[2] );
	
	}
	
	if( request.getParameter( "category_seq" ) != null ) {
		categorySeq = Integer.parseInt( request.getParameter( "category_seq" ) );   // int형 변수 categorySeq에 대입
	}
	
	BoardDTO bto = new BoardDTO();
	MemberDTO mto = new MemberDTO();
	MemberShipDTO msto = new MemberShipDTO();
	
	StringBuilder sb = new StringBuilder();
	
	for( FacilityDTO fto :list ){
		
	String tag = fto.getTag();
	int seq = fto.getB_seq();
	String title = fto.getTitle();
	String imageName = fto.getImage_name();
	String address = fto.getAddress();
	String[] facilityAddress = fto.getAddress().split( " " );
	int price =  fto.getPrice(); 
		
		// 위치 X, 카테고리 X     ==>   전체 리스트 출력
		if( ( dongAddr == null ) && ( categorySeq == 0 ) ){
			sb.append("	<div class='col'>");
			sb.append("		<div class='card shadow-sm'>");
			sb.append("			<a href='/facility/" + seq + "'>");
			sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...' /></a>");
			if( tag != null ) {
				sb.append("			<span class='label-top'>" + tag + "</span>");
			}
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
			sb.append("					<a href='/facility/" + seq + "#memberShip' class='btn btn-warning'>회원권 예약</a>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("	</div>"); 
			
		// 위치 X, 카테고리 O	
		} else if( (dongAddr == null ) && (categorySeq != 0 ) ){
			if( categorySeq == fto.getCategory_seq() ) {
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='/facility/" + seq + "'>");
				sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...' /></a>");
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
				sb.append("					<a href='/facility/" + seq + "#memberShip' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
			
		// 위치 O, 카테고리 X	
		} else if( (dongAddr != null ) && (categorySeq == 0 ) ){
			if( dongAddr[2].contains( facilityAddress[2] ) ) {
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='/facility/" + seq + "'>");
				sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...' /></a>");
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
				sb.append("					<a href='/facility/" + seq + "#memberShip' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
		
		// 위치 O, 카테고리 O
		} else if( (dongAddr != null ) && (categorySeq != 0 ) ){
			if( dongAddr[2].equals( facilityAddress[2] ) && categorySeq == fto.getCategory_seq() ) {
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='/facility/" + seq + "'>");
				sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...' /></a>");
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
				sb.append("					<a href='/facility/" + seq + "#memberShip' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
		}
	}

%>



<hr />
<% if( request.getParameter( "type" ) == null || !request.getParameter("type").equals( "C" ) ) {%>
<!-- 내 주변 운동시설-->
<div class="container md-5" style="padding-left: 60px">
	<div class="current-menu container-xl">
		<a href="/home">홈</a> &gt; 내 주변 운동시설
	</div>
	<div class="current-location container-xl">
		<div class="desktop-location-view ng-star-inserted">
			<i class="bi bi-geo-alt" id="getAddr"> <%=fullDongAddr %></i>
			<div class="btn-view float-end">
				<a href="/facility/loc" class="clickable"> 위치지정</a>
			</div>
		</div>
	</div>
</div>
<hr />

<%} else if( request.getParameter("type").equals( "C" ) ) { %>
<!-- 글쓰기 버튼 -->
<div class="col text-end">
  <a class="btn btn-secondary me-md-5 px-3 mb-4" type="button" href="/facility/write">글쓰기</a>
</div>

<%} %>

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
		
		//위치(dongAddr)X / 카테고리(category_seq) X   ==>   카테고리 번호 파라미터 추가
		if( !( urlParams.has( "address" ) ) && !( urlParams.has( "category_seq" ) ) ) {
			
			urlParams.append( "category_seq", categorySeq );
			location.href = url;
		
		// dongAddr X / category_seq O			  ==>		카테고리 번호 파라미터 변경
		} else if( !( urlParams.has( "address" ) ) && ( urlParams.has( "category_seq" ) ) ) {
			
			urlParams.set( "category_seq", categorySeq );
			location.href = url;
			
		// dongAddr O / category_seq X	  	  ==> 		  카테고리 번호 파라미터 추가
		} else if( urlParams.has( "address" ) && !( urlParams.has( "category_seq" ) ) ){ 
			
			urlParams.append( "category_seq", categorySeq );
			location.href = url
			
		// dongAddr O / category_seq O	  	  ==> 		  카테고리 번호 파라미터 변경
		} else if( urlParams.has( "address" ) && ( urlParams.has( "category_seq" ) ) ) {
			
			urlParams.set( "category_seq", categorySeq );
			location.href = url; 
		}
		
	});
});	
</script>