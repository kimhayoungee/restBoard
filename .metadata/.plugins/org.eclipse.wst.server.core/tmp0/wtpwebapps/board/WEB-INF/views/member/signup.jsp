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
                        	
                        	<div class="table-responsive">
                         	<table class="table">
                        		<tr>
                        			<td><label>아이디</label> <input class="form-control" name='mid' style="width:300px;"><button id="idChkBtn">아이디 중복확인</button>
                        			</td>
                        		</tr> 
                        		
                        		<!-- 중복확인 ajax -->
                        		
                        		<tr>
                        			<td><label>비밀번호</label> <input class="form-control" name='mpw' style="width:300px;"></td>
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


</body>

</html>