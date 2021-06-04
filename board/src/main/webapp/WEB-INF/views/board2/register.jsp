<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<%@include file="../includes/header.jsp" %>

                <!-- Begin Page Content -->			
                <div class="container-fluid">
               		<p class="mb-4">게시글 쓰기</p>
               		
               		<div class="card shadow mb-4">
               			<div class="card-header py-3"0>
               				<h6 class="m-0 font-weight-bold text-primary">게시글 작성</h6>
               			</div> 
               			
               			<div class="card-body">
               				<form method="post" id="regForm">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        	<div class="form-group">
                        		<label>제목</label> <input class="form-control" name='btitle'>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label> <textarea class="form-control" name='bcontent'></textarea>
                        		<!--  <textarea class="summernote" name='bcontent'></textarea> -->
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label> <input class="form-control" name='bid' value='<sec:authentication property="principal.username" />' readonly>
                        	</div>
                        	
                        	</form>
                        	
                        	<button type="submit" id="regBtn" class="btn btn-primary">등록</button>
                        	<button type="submit" id="listBtn" class="btn btn-primary">취소</button>
                        	
                        	<form id="moveForm" method="get">
                        		<!-- 페이지,검색정보 추가 -->
                        	</form>
               			</div> <!-- end of card-body -->
               		</div> <!-- end of card -->
               		
               		<div class="card shadow mb-4">
               			<!-- 첨부파일 추가 -->
               		</div>
               		
				</div> <!-- end of container-fluid -->
				
<%@include file="../includes/footer.jsp" %>

	<!-- 스크립트 -->
	<script>
	$(document).ready(function(){
		var rf = $('#regForm');
		
		$("#regBtn").on("click", function(e){
			e.preventDefault();
			console.log("submit 클릭");
			rf.attr("action", "/board2/register");
			rf.submit();
			//첨부파일 부분 추가
			
		});
	
		
	});	//end of ready
	
	$("#listBtn").on("click", function(){
		
		$("#moveForm").attr("action", "/board2/list").submit();
		
	});
	</script>
</body>
</html>