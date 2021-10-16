<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
var desc = ['all', 'korea', 'japan', 'western', 'china'];
$(document).ready(function(){
	$("#desc a").each(function(index, item){
			$("#" + desc[index]).on("click", function(){
				text = $("#" + desc[index]).data("value");
				$.ajax({
					url : "/myzzimdesc",
					type : "post",
					data : {"recipe_desc" : text},
					dataType : "json", 
					success : function(answer){
						if(answer.length == 0){
							$("#dis").empty();
						}else{
							for(var i=0; i<answer.length; i++){
								var length = answer.length;
								if(i == 0){
									$("#dis").empty();
								}
								if(i < 6){
									$("#dis").append(" <div style='display:inline-block'>" +
											"<a href='javascript:void(0);' onclick=detail('" + answer[i].recipe_no + "');>" +
											"<img alt='오류' src='" + answer[i].recipe_img + "' width='200' height='200'></a><br>" + 
											answer[i].recipe_title + "(" + answer[i].recipe_name + ")" + 
											"<a href='javascript:void(0);' onclick=delete1('" + answer[i].recipe_no + "');>" + 
											"<img title='목록에서 제거' alt='오류' src='하트.png' width='20' height='20'></a></div>");
								}else{
									$("#dis").append(" <div class='hide' style='display:none;'>" +
											"<a href='javascript:void(0);' onclick=detail('" + answer[i].recipe_no + "');>" +
											"<img alt='오류' src='" + answer[i].recipe_img + "' width='200' height='200'></a><br>" + 
											answer[i].recipe_title + "(" + answer[i].recipe_name + ")" + 
											"<a href='javascript:void(0);' onclick=delete1('" + answer[i].recipe_no + "');>" + 
											"<img title='목록에서 제거' alt='오류' src='하트.png' width='20' height='20'></a></div>");
								}
	
						}			
					}
						
					if(answer.length > 6){
						$("#div_add").html("<a id='add' href='#'>더보기</a>")
					}else{
						$("#div_add").empty();
					}
					
					$("#add").on("click", function(){
						$(".hide").attr("style", "display:inline-block");
						$("#div_add").empty();
					});
					

						
				}
			});
		});
	
	});

}); 




</script>

</head>
<body>
	<h3>마이페이지</h3>
	<hr>
	<h3>찜한 레시피</h3>
	<div id="desc">
	<a id="all" href="#" data-value="전체">전체</a>
	<a id="korea" href="#" data-value="한식">한식</a>
	<a id="japan" href="#" data-value="일식">일식</a>
	<a id="western" href="#" data-value="양식">양식</a>
	<a id="china" href="#" data-value="중식">중식</a>
	</div>
	<hr>
	
	<div id="dis" style="display:block">
		<c:forEach items="${myzzimrecipelist }" var="myzzimrecipelist" varStatus="status">
			<c:if test="${status.index < 6}">
				<div style="display:inline-block">
					<a href='javascript:void(0);' onclick="detail('${myzzimrecipelist.recipe_no}');">
					<img alt="오류" src="${myzzimrecipelist.recipe_img }" width="200" height="200"></a><br>
					${myzzimrecipelist.recipe_title }(${myzzimrecipelist.recipe_name })
					<a href='javascript:void(0);' onclick="delete1('${myzzimrecipelist.recipe_no}');">
					<img title="목록에서 제거" alt="오류" src="하트.png" width="20" height="20"></a>
				</div>
			</c:if>
			
			<c:if test="${status.index > 5}">
			<div class="hide" style="display:none;">
				<a href='javascript:void(0);' onclick="detail('${myzzimrecipelist.recipe_no}');">
				<img alt="오류" src="${myzzimrecipelist.recipe_img }" width="200" height="200"></a><br>
				${myzzimrecipelist.recipe_title }(${myzzimrecipelist.recipe_name })
				<a href='javascript:void(0);' onclick="delete1('${myzzimrecipelist.recipe_no}');">
				<img title="목록에서 제거" alt="오류" src="하트.png" width="20" height="20"></a>	
			</div>
			</c:if>
			
		</c:forEach>	
	</div>
		<c:if test="${fn:length(myzzimrecipelist) > 6}">
			<div id="div_add">
				<a id="add" href="#" data-value="더보기">더보기</a>
			</div>
		</c:if>
		<script>
			$("#add").on("click", function(){
				$(".hide").attr("style", "display:inline-block");
				$("#div_add").empty();
			});
			
			function delete1(recipe_no){
				var result = confirm("정말로 목록에서 삭제하시겠습니까?");
				if(result){
					alert("찜한레시피 메인으로 이동합니다.");
					location.href = "http://localhost:9009/myzzimdelete?recipe_no=" + recipe_no;
				}
			}
			
			function detail(recipe_no){
				var result = confirm("해당 레시피로 이동하시겠습니까?");
				if(result){
					location.href = "http://localhost:9009/recipedetail?recipe_no=" + recipe_no;
				}
			}
			
		</script>
</body>
</html>