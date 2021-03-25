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
                        	<form method="post" id="regForm">
                        	
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        	
                        	<div class="table-responsive">
                         	<table class="table table-bordered">
                        		<tr>
                        			<td><label>아이디</label> <input class="form-control" name='mid'></td>
                        		</tr> 
                        		
                        		<!-- 중복확인 ajax -->
                        		
                        		<tr>
                        			<td><label>비밀번호</label> <input class="form-control" name='mpw'></td>
                        		</tr>
                        		<tr>
                        			<td><label>비밀번호 확인</label> <input class="form-control" name='mpwChk'></td>
                        		</tr>
                        		
                         		<tr>
                        			<td><label>생년월일</label> <input class="form-control" name='mbirth'></td>
                        		</tr>                       		
                        		
                        		<tr>
                        			<td><label>주소</label> <input class="form-control" name='maddress'></td>
                        		</tr>
                        	</table>                       	
                        	</div>
                        	
                        	</form>
                        	
                        	<button type="submit" id="regBtn" class="btn btn-primary">등록</button>
                        	<button type="submit" id="listBtn" class="btn btn-primary">취소</button>
                        	
                        	<form id="moveForm" method="get">
	<%--                          	<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	                        	<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
	                        	<input type="hidden" name='type' value='<c:out value="${cri.type}"/>'>
	                        	<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}"/>'>     --%>                   	
                        	</form>
                        </div>
                    </div>
                    <div class="card shadow mb-4">    
                        <div class="card-header py-3">
		       				<h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                        </div>
                        <div class="card-body">
                        	<div class="form-group uploadDiv">
                        		<input type="file" name='uploadFile' multiple>
                        	</div> 	
                        	
                        	<div class='uploadResult'>
                        		<ul>
                        		
                        		</ul>
                        	</div>
                        	
                        </div>
                    </div>
                    
                </div>
                <!-- /.container-fluid -->

	<%@include file="../includes/footer.jsp" %>
	
	
<!-- 스크립트 -->


</body>

</html>