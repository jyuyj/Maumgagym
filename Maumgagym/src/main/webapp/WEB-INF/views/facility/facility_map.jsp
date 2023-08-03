<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f61974c964e26a20af178434325c0690&libraries=services"></script>
<script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
<script src="../resources/asset/script/jquery-3.6.0.js"></script>
<script src="../resources/asset/js/owl.carousel.min.js"></script>
<link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resources/asset/css/facility_list.css" rel="stylesheet" />
<script src="../resources/asset/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap icons-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

</head>
<body>

	<!-- 내 주변 운동시설-->
	<div class="container md-5" style="padding-left: 60px">
		<div class="current-menu container-xl">
			<a href="/home">홈</a> &gt; 내 주변 운동시설
		</div>
		<div class="current-location container-xl">
			<div class="desktop-location-view ng-star-inserted">
				<i class="bi bi-geo-alt"> <span id="centerAddr"></span>
				</i>
			</div>
		</div>
	</div>

	<br />
	<div class="container md-5" style="padding-left: 60px">
		<div
			class="row row-cols-1 row-cols-xs-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			<div id="map"
				style="width: 1250px; height: 650px; position: relative; overflow: hidden;"></div>
			<form class="d-grid gap-2 col-6 mx-auto px-5 py-5"
				action="/facility/address" method="GET" id="facility">
				<input type="hidden" id="dongAddr" name="dongAddr" value="" /> <input
					class="btn btn-warning2 btn-lg" id="link1" type="button"
					value="이 근처 운동시설 찾기" onclick="link1_click();" />
			</form>
		</div>
	</div>

	<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = { 
        center: new kakao.maps.LatLng(37.497, 127.0254), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
    
//지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

function relayout() {    
    
    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
    map.relayout();
}

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition,
    });

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);


// 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'center_changed', function() {

    // 지도의  레벨을 얻어옵니다
    var level = map.getLevel();

    // 지도의 중심좌표를 얻어옵니다 
    var latlng = map.getCenter(); 

	marker.setPosition(latlng);
	
	
	kakao.maps.event.addListener(map, 'idle', function() {

		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		//현재 지도 중심좌표로 주소를 검색해서 콘솔에 표시합니다
		searchAddrFromCoords(map.getCenter(), addr);
		
		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}

		function addr( result, status ) {
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');
				setTimeout(() => infoDiv.innerHTML = result[0].address_name, 1000);
				//infoDiv.innerHTML = result[0].address_name;
			} 
		}
	
	});
	
});

	 // 아이디가 link1인 input태그의 버튼을 클릭하면 함수 실행
 		function link1_click() {
		var data = $("#centerAddr").text();  // 지도에서 받은 행정동 주소를 data로 넣고 
		if( data != null ) {	// dat가 null이 아니면
			location.href="/facility?address="+data;  // 링크 이동 
			
		}
	}

</script>

</body>
</html>