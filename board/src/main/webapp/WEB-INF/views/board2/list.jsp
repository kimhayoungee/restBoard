<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                
                	<!-- Page Heading -->
                	<h1 class="h3 mb-2 text-gray-800">게시판</h1>
                	<p class="mb-4">---</p>
                	
                	<!-- DataTales Example -->
                	<div class="card shadow mb-4">
                		
                		<!-- 검색 -->
                		<div class="card-header py-3" align="right">
                			<form id='searchForm' action='/board2/list' method='get'>
                				<div class="input-group">
                					<select>
                						<!-- 검색조건 넣기 -->
                					</select>
                					
                					<div class="input-group-append">
                						<button id='searchBtn' class="btn btn-primary" type="button">
                							<i class="fas fa-search fa-sm"></i>
                						</button>
                						&nbsp;
                						<button id='regBtn' type="button" class="btn btn-outline-primary">새 글 등록</button>
                						&nbsp;
                						<sec:authorize access="hasRole('admin')">
                						<button id='' type="button" class = "btn btn-outline-primary">엑셀로 다운받기</button>
                						</sec:authorize>
                					</div>
                				</div>
                			</form>
                		
                		</div> <!-- 검색 끝 -->
                		
                		<!-- 글목록 -->
                		<div class="card-body">
                			<div class="table-responsive">
                				<table class="table table-bordered" width="100%" cellspacing="0">
                					<thead>
                						<tr>
                							<th>번호</th>
                							<th>제목</th>
                							<th>내용</th>
                							<th>조회수</th>
                							<th>작성자</th>
                							<th>작성일</th>
                						</tr>
                					</thead>
                					
                					<c:forEach items="${boardList}" var="board">
                						<tr>
                							<td><c:out value="${board.bno}"></c:out></td>
                							<td>
                								<a class='move' href='<c:out value="${board.bno}" />'>
                								<c:out value="${board.btitle}" />
                								<i class="fas fa-paperclip fa-sm"></i><c:out value="${board.battachcnt}" /></a>
                							</td>
                							<td><c:out value="${board.bcontent}"></c:out></td>
                							<td><c:out value="${board.bhit}"></c:out></td>
                							<td><c:out value="${board.bid}"></c:out></td>
                							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.bregdate}" /></td>
                						</tr>
                					</c:forEach>
                				</table>
                				
                				<!-- 페이징 -->
                				<div class="float-sm-right">
                					<ul class="pagination">
                						<c:if test="">
                						
                						</c:if>
                					</ul>
                					
                					<form id="actionForm" action="" method="get">
                					
                					</form>
                				</div>
                				
                				<!-- 모달창 -->
                				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                					<div class="modal-dialog">
                						<div class="modal-content">
                							<div class="modal-header">
                								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                							</div>
                							<div class="modal-body" align="center">처리가 완료되었습니다.</div>
                							<div class="modal-footer">
                								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                							</div>
                						</div>
                					</div>
                				</div> <!-- 모달창 끝 -->
                				
                				
                			</div>
                		</div>
                	</div>
                </div> <!-- /.container-fluid -->
                
		<%@include file="../includes/footer.jsp" %>
		
		<!-- 스크립트 -->
		<script type="text/javascript">
			$(document).ready(function(){
				
				var af = $('#actionForm');
				//제목 클릭시 페이지 이동
				$(".move").on("click", function(e){
					e.preventDefault();
					af.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
					af.attr("action", "/board2/detail");
					af.submit();
				});
				
				$("#regBtn").on("click", function(){
					self.location = "/board2/register";
				});
			});
		
		</script>
</body>
</html>