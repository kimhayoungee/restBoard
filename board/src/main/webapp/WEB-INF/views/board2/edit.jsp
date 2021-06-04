<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%@ include file="../includes/header.jsp" %>

                <!-- Begin Page Content -->			
                <div class="container-fluid">
               		<p class="mb-4">---</p>
               		
               		<div class="card shadow mb-4">
               			<div class="card-header py-3"0>
               				<h6 class="m-0 font-weight-bold text-primary">게시글 수정</h6>
               			</div> 
               			
               			<div class="card-body">
               				<form method="post" id="regForm">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        	<div class="form-group">
                        		<label>제목</label> <input class="form-control" name='btitle' value='<c:out value="${bvo.btitle }"/>'>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label> <textarea class="form-control" name='bcontent'> <c:out value="${bvo.bcontent}" /></textarea>
                        		<!--  <textarea class="summernote" name='bcontent'></textarea> -->
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label> <input class="form-control" name='bid' value='<c:out value="${bvo.bid }" />' readonly>
                        	</div>
                        	
                        	<input type="hidden" name='bno' value='<c:out value="${bvo.bno}"/>'>
                        	</form>
                        	
                        	
                        	<button type="submit" id="editBtn" class="btn btn-primary">수정</button>
                        	<button type="submit" id="removeBtn" class="btn btn-primary">삭제</button>
                        	
                        	<!-- 목록으로 버튼 추가?  -->
                        	
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
		var rf = $("#regForm");
		
		$("#editBtn").on("click", function(e){
			rf.attr("action", "/board2/edit").submit();
		});
		
		$("#removeBtn").on("click",function(e){
			rf.attr("action", "/board2/remove").submit();
		});
	});

</script>

</body>
</html>