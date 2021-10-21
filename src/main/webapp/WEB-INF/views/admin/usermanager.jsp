<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DataTable - Mazer Admin Dashboard</title>
	
	<!-- 공통 -->
	<meta name="msapplication-TileImage" content="/assets/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

	<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;300;400;600;700;900&amp;display=swap" rel="stylesheet">

    <!--    Stylesheets-->
    <link href="/assets/css/theme.css" rel="stylesheet" />
	<!-- 공통 -->
	
	
	<link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css">

    <link rel="stylesheet" href="adminassets/vendors/simple-datatables/style.css">

    <link rel="stylesheet" href="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="adminassets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="adminassets/css/app.css">
    <link rel="shortcut icon" href="adminassets/images/favicon.svg" type="image/x-icon">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script src="/vendors/fontawesome/all.min.js"></script>
	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script>
		/* 비번, 이름 정규식 체크 */
		const regex = /^.{8,16}$/;
		const regex2 = /^[가-힣a-zA-Z]+$/;
	</script>
	
	
</head>





<body>
	
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include><br>
	
    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active" style="background-color: #FFB30E !important">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="index.html"><img src="assets/images/logo/logo.png" alt="Logo" srcset=""></a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                       
                        <li class="sidebar-item" style="color: #ffc107!important; background-color: white; border-radius:.25rem;">
                            <a href="/usermanager" class='sidebar-link'>
                                <i class="bi bi-file-earmark-spreadsheet-fill"></i>
                                <span>회원관리</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>
        </div>
        
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading" style="margin-top:100px;">
                <div class="page-title">
                    <div class="row" >
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>회원 리스트</h3>
                        </div>

                    </div>
                </div>
                <section class="section" style="padding-top:3rem;">
                    <div class="card">
                        <div class="card-body">
                            <table class="table table-striped" id="table1">
                                <thead>
                                    <tr>
                                        <th>이 름</th>
                                        <th>이메일</th>
                                        <th>비밀번호</th>
                                        <th>휴대전화</th>
                                        <th>주 소</th>
                                        <th id="edit">수정</th>
                                        <th id="remove">삭제</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${userlist }" var="userlist" varStatus="status">
									
									<tr>
										<td>${userlist.user_name }</td>
										<td>${userlist.user_email }</td>
										<td>${userlist.user_pw }</td>
										<!-- 폰 정보 -단위로 끈어서 보여주기 -->
										<td><c:set var="TextValue" value="${userlist.user_phone}"/>
											${fn:substring(TextValue,0,3) }-${fn:substring(TextValue,3,7) }-${fn:substring(TextValue,7,11)}
										</td>
										<td>${userlist.user_address }</td>
										<td>
										<a href="#" id="${userlist.user_no}edit" data-bs-toggle="modal" data-bs-target="#modal1${userlist.user_no }">
										<i class="fas fa-edit"></i></a>
										</td>
										<td>
										<a href="#" id="${userlist.user_no}delete">
										<i class="fas fa-trash" style="color:red;"></i></a>
										</td>
									</tr>
									
									
									<!-- 모달 -->
                                            <div class="modal fade text-left" id="modal1${userlist.user_no }" tabindex="-1"
                                                role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                                                    role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel33">회원정보 수정 </h4>
                                                            <button type="button" class="close" data-bs-dismiss="modal"
                                                                aria-label="Close">
                                                                <i data-feather="x"></i>
                                                            </button>
                                                        </div>
                                                        <form action="#">
                                                            <div class="modal-body">
                                                                <label>이메일: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="ex)xxx@xxx.com"
                                                                        class="form-control" 
                                                                        id='${userlist.user_no}user_email' value='${userlist.user_email}'>
                                                                </div>
                                                                
                                                                
                                                                <label>비밀번호: </label>
                                                                <div class="form-group">
                                                                    <input type="password" placeholder=""
                                                                        class="form-control" 
                                                                        id='${userlist.user_no}user_pw' value='${userlist.user_pw}'>
                                                                </div>
                                                                <label>(8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.)</label><br><br>
                                                                
                                                                <label>이름: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder=""
                                                                        class="form-control" 
                                                                        id='${userlist.user_no}user_name' value='${userlist.user_name}'>
                                                                </div>
                                                                <label>(한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가))</label><br><br>
                                                                
                                                                <label>휴대전화: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="ex)xxx-xxxx-xxxx"
                                                                        class="form-control" 
                                                                        id='${userlist.user_no}user_phone' value='${userlist.user_phone}'>
                                                                </div>
                                                                
                                                                
                                                                <c:set var="imsi" value="${userlist.user_address}"/>
																<c:set var="address" value="${fn:split(imsi,',')}"/>					
                                                                <label>주소: </label>
                                                                <div class="form-group">
                                                                	<input type="text" placeholder="우편번호"
                                                                        class="form-control w-25" style="display:inline;" id='${userlist.user_no}user_address1' value='${address[0]}'>
                                                                        <button type='button' class="btn btn-primary ml-1" style="display:inline;" onclick="execPostCode${userlist.user_no}();">우편번호</button>
                                                                    <input type="text" placeholder="도로명주소"
                                                                        class="form-control w-100 mt-1 mb-1" id='${userlist.user_no}user_address2' value='${address[1]}'>
                                                                    <input type="text" placeholder="상세주소"
                                                                        class="form-control" id='${userlist.user_no}user_address3'>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-primary ml-1" 
                                                                    id="${userlist.user_no}check" onclick="test3${userlist.user_no}();">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">완 료</span>
                                                                </button>
                                                                <button type="button" class="btn btn-light-secondary"
                                                                    data-bs-dismiss="modal">
                                                                    <i class="bx bx-x d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">취 소</span>
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
									<!-- 모달 -->
									
									
									
									
									
									<script>	
										/* 우편번호 찾기 api */
										function execPostCode${userlist.user_no}() {
										    new daum.Postcode({
										        oncomplete: function(data) {
										           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
							
										           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
										           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
										           var extraRoadAddr = ''; // 도로명 조합형 주소 변수
							
										           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
										           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
										           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
										               extraRoadAddr += data.bname;
										           }
										           // 건물명이 있고, 공동주택일 경우 추가한다.
										           if(data.buildingName !== '' && data.apartment === 'Y'){
										              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										           }
										           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
										           if(extraRoadAddr !== ''){
										               extraRoadAddr = ' (' + extraRoadAddr + ')';
										           }
										           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
										           if(fullRoadAddr !== ''){
										               fullRoadAddr += extraRoadAddr;
										           }
							
										           // 우편번호와 주소 정보를 해당 필드에 넣는다.
										           console.log(data.zonecode);
										           console.log(fullRoadAddr);
										           
										           
										           $("#${userlist.user_no}user_address1").val(data.zonecode);
										           $("#${userlist.user_no}user_address2").val(fullRoadAddr);
										           
										       }
										    }).open();
										}
										
										/* 모달에 완료버튼 액션 - 정규식으로 비번, 이름 체크하고 이상없으면 url에 수정 정보 붙여서 보내기 */
										function test3${userlist.user_no}(){
											var test1 = $('#${userlist.user_no}user_pw').val();
											var test2 = $('#${userlist.user_no}user_name').val();
											if(!regex.test(test1)){
												alert('암호 오류');
											}else if(!regex2.test(test2)){
												alert('이름 오류');
											}else{
												location.href = "http://localhost:9009/usermodify?user_no=" + 
															${userlist.user_no} + "&user_email=" + 
															$('#${userlist.user_no}user_email').val() + "&user_pw=" + 
															$('#${userlist.user_no}user_pw').val() + "&user_name=" + 
															$('#${userlist.user_no}user_name').val() + "&user_phone=" + 
															$('#${userlist.user_no}user_phone').val() + "&user_address=" + 
															$('#${userlist.user_no}user_address1').val() + "," + $('#${userlist.user_no}user_address2').val() +
																											"," + $('#${userlist.user_no}user_address3').val();
												 
											}
										}
										
										/* 수정버튼, 취소버튼 액션 - 모달 열고 닫기 */
										/* $(document).ready(function(){
											$("#${userlist.user_no}edit").on("click", function(){
												$("#${userlist.user_no}modal1").fadeIn(); 
											});
											$(".modal_cancel").on("click", function(){
												$("#${userlist.user_no}modal1").fadeOut(); 
											});
										});	 */
										
										/* 삭제 버튼 눌렀을때 액션 - url에 해당 유저 정보 붙여서 보내서 삭제*/
										$(document).ready(function(){
											
												$("#${userlist.user_no}delete").on("click", function(){
													var result = confirm("정말로 해당회원을 삭제하시겠습니까?");
													if(result){
														$(location).attr("href", "http://localhost:9009/userdelete?user_no=" + ${userlist.user_no});
													}
												});
											
										});
									</script>
									
									
									
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </section>
            </div>

            <section class="py-0 pt-7 bg-1000">

        <div class="container">

          <hr class="border border-800" />
          <div class="row flex-center pb-3">
            <div class="col-md-6 order-0">
              <p class="text-200 text-center text-md-start">All rights Reserved &copy; Your Company, 2021</p>
            </div>
            <div class="col-md-6 order-1">
              <p class="text-200 text-center text-md-end"> Made with
                &nbsp;by&nbsp;<a class="text-200 fw-bold" href="https://themewagon.com/" target="_blank">multicampus </a>
              </p>
            </div>
          </div>
        </div><!-- end of .container-->

      </section>
            
            
        </div>
    </div>
    <script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>

    <script src="adminassets/vendors/simple-datatables/simple-datatables.js"></script>
    <script>
        // Simple Datatable
        let table1 = document.querySelector('#table1');
        let dataTable = new simpleDatatables.DataTable(table1);
    </script>

    <script src="adminassets/js/main.js"></script>
    
	<script>
		$('#remove').html("삭제");
		$('#edit').html("수정");
	</script>
    
    
    
</body>

</html>