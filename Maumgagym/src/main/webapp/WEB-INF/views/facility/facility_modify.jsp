<%@page import="com.maumgagym.dto.MemberShipDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.ReviewDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.maumgagym.dto.MemberDTO"%>
<%@page import="java.util.Map"%>
<%@page import="com.maumgagym.dto.BoardDTO"%>
<%@page import="com.maumgagym.dto.FacilityDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	//세션을 통해 로그인한 회원의 id받아옴
	String id = null;
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}
	FacilityDTO fto = (FacilityDTO)request.getAttribute( "fto" );

/* 	Map<String, Object> map = (HashMap) request.getAttribute("map");
	BoardDTO bto = (BoardDTO)map.get("bto"); */
	
/* 	int seq = fto.getB_seq();
	System.out.println("글번호 : " + seq);
	String title = fto.getTitle();
	String content = fto.getContent();
	String mid = fto.getId();
	int period = fto.getPeriod();
	int price = fto.getPrice(); */
	
	int seq = fto.getB_seq();
	System.out.println("글번호 : " + seq);
	String title = fto.getTitle();
	String content = fto.getContent();
	String mid = fto.getId();
	
	

/* 	// 회원권 관련
	ArrayList<MemberShipDTO> msList = (ArrayList) map.get( "membershipList" );
	StringBuilder sbMembershipInfo = new StringBuilder();
	int selectLopNum = 0;
	for( MemberShipDTO msto : msList ) {
		selectLopNum++;
		sbMembershipInfo.append( "<option value='" + msto.getMembership_seq() +"'>" + msto.getMembership_period() + "개월권" +"</option>" );
	}
	// 공지 관련
	 ArrayList<BoardDTO> noticeList = (ArrayList) map.get("noticeList");
	// 이미지 관련
	 ArrayList<BoardDTO> imageList = (ArrayList) map.get("imageList");
	// 이미지 
	BoardDTO btoMainImage = imageList.get(0); */
%>

<script type="text/javascript">
	function selectseq() {
		var selected = document.getElementById("category");

		var seq = selected.options[document.getElementById("category").selectedIndex].value;
	}

	window.onload = function() {

		document.getElementById('mbtn').onclick = function() {
			if (document.getElementById("category").selectedIndex == 0) {
				alert("카테고리를 선택해 주세요.");
				return false;
			}

			if (document.mfrm.subject.value.trim() == "") {
				alert("제목을 입력해 주세요.");
				return false;
			}

			if (document.mfrm.content.value.trim() == "") {
				alert("내용을 입력해 주세요.");
				return false;
			}

			document.mfrm.submit();
		}
	}
</script>

<hr />
<br />
<br />
<div class="container px-3">
	<div class="row">
		<div class="col-sm-2 h3 fw-bold py-3">글수정하기</div>
		<div class="col-sm-10 text-secondary fs-6 fw-lighter"
			style="margin-top: 25px">회원권 금액은 숫자만 입력 가능합니다.</div>
	</div>
	<div class="con_txt">
		<form action="/facility/modifyOK?seq=<%=seq %>" method="post" name="mfrm"
			enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<th class="fs-bold fw-4 bg-light" width="15%">카테고리</th>
					<td><select class="form-select" role="button" id="category"
						name="category" onchange="selectseq()">
							<option selected>카테고리를 선택해 주세요.</option>
							<option value="1">피트니스</option>
							<option value="2">요가</option>
							<option value="3">수영</option>
							<option value="4">테니스</option>
							<option value="5">타바타</option>
							<option value="6">필라테스</option>
							<option value="7">골프</option>
							<option value="8">복싱</option>
							<option value="9">댄스</option>
					</select> <input type="hidden" id="id" name="id"
						value="<%=id%>" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">제목</th>
					<td><input type="text" name="title" id="title" value="<%=title %>"
						class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(1개월)</th>
					<td><input type="text" name="membership1" id="membership"
						onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=""
						class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(3개월)</th>
					<td><input type="text" name="membership3" id="membership"
						onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=""
						class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(6개월)</th>
					<td><input type="text" name="membership6" id="membership"
						onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=""
						class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">회원권(12개월)</th>
					<td><input type="text" name="membership12" id="membership"
						onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=""
						class="form-control" /></td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">내용</th>
					<td><textarea id="content" name="content" class="form-control" ><%=content %></textarea>
					</td>
				</tr>
				<tr>
					<th class="fs-bold fw-4 bg-light">첨부파일</th>
					<td><input type="file" name="upload" value=""
						class="board_view_input" /></td>
				</tr>

			</table>
			<div class="col text-end">
				<button type="submit" id="mbtn"
					class="btn btn-outline-secondary mb-3">수정하기</button>
			</div>
		</form>
	</div>
</div>