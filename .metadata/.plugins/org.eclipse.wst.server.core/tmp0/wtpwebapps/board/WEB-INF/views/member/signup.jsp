<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   

<%@include file="../includes/header.jsp" %>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                  <!--   <h1 class="h3 mb-2 text-gray-800">게시글 쓰기</h1> -->
                 <!--    <p class="mb-4">회원 가입</p> -->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
		       				<h6 class="m-0 font-weight-bold text-primary">회원 가입</h6>
                        </div>
                        <div class="card-body">
                        	<form method="post" id="signupForm">
                        	
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        	
                        	<div class="input-group">
                         	<table class="table">
                        		<tr>
                        			<td>아이디
                        			<div class="input-group-append">
                        				<input class="form-control" name='mid' id='mid' style="width:300px;">
                        				<button id="idChkBtn" class="btn">아이디 중복확인</button>
                        			</div>
                        			</td>
                        		</tr> 
                        		
                        		<!-- 중복확인 ajax -->
                        		
                        		<tr>
                        			<td><label>비밀번호</label> <input class="form-control" name='mpw' id='mpw' style="width:300px;"></td>
                        		</tr>
                        		<tr>
                        			<td><label>비밀번호 확인</label> <input class="form-control" name='mpwChk' style="width:300px;"></td>
                        		</tr>
                        		
                         		<tr>
                        			<td><label>생년월일</label> <input class="form-control" name='mbirth' style="width:300px;"></td>
                        		</tr>                       		
                        		
                        		<tr>
                        			<td><label>주소</label> <input class="form-control" name='maddress' style="width:300px;"></td>
                        		</tr>
                        	</table>                       	
                        	</div>
                        	
                        	</form>
                        	
                        	<button type="submit" id="regBtn" class="btn btn-primary">등록</button>
                        	<button type="submit" id="listBtn" class="btn btn-primary">취소</button>
                        	
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

	<%@include file="../includes/footer.jsp" %>
	
	
<!-- 스크립트 -->

<script>
	$(document).ready(function(){
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("#idChkBtn").on("click",function(){
			console.log("아이디 중복체크 클릭");
			var midval = $("#mid").val();
			
			if(midval==""){
				alert("아이디를 입력하세요."); 
				return
			} 
			
			$.ajax({
				 type:"post"
				,url:"/member/idcheck"
				,data: {"mid" : midval}
				,beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				}
				,success:function(data){
					alert("성공 : ");
					if(data.result>0){
						alert("이미 존재하는 아이디입니다.");
						$("#mid").focus();
					}else{
						alert("사용 가능한 아이디입니다.");
						$("#mpw").focus();
					}
				}
				,error: function(xhr, status, err){
					error(err);
					alert(err);
				}
			});

		}); //end of 버튼
		
		
	});
</script>

</body>

</html>