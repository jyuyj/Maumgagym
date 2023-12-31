<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = null;
	if( session.getAttribute( "id" ) != null ) {
		id = (String) session.getAttribute( "id" );
	} else {
		id = null;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="../resources/asset/css/facility_list.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- script -->
    <script src="../resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="../resources/asset/js/owl.carousel.min.js"></script>
    
    <!-- Summernote -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	
	<link href="../resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	<!--  header news -->
	<link rel="stylesheet" href="./resources/asset/css/news.css"/>
</head>
<body>
	
	<!-- header -->
	<jsp:include page="./include/header.jsp">
		<jsp:param name="userID" value="<%=id%>" />
	</jsp:include>
	<jsp:include page="./main/main_source/main_search.jsp" />
	
	<!-- 운동시설 글수정 -->
	<jsp:include page="./facility/facility_modify.jsp" />
	
	<!-- footer -->
	<jsp:include page="./include/footer.jsp" />
	
    <!--  header news -->
	<script src="../resources/asset/js/news.js"></script>
    
</body>
</html>