<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
                			<form>
                				<div class="input-group">
                					<select>
                					
                					</select>
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
                					
                					<c:forEach items="" var="">
                						<tr>
                							<td></td>
                							<td></td>
                							<td></td>
                							<td></td>
                							<td></td>
                							<td></td>
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
</body>
</html>