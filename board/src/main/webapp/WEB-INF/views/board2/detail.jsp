<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
	
    <!-- css -->
    <style>
    .uploadResult ul{
    	display: flex;
    	flex-flow: row;
    	justify-content: center;
    	align-items: center;
    }
    .uploadResult ul li{
    	list-style: none;
    	padding: 10px;
    	align-content: center;
    	text-align: center;
    }
    .uploadResult ul li img{
    	width: 100px;
    }
    .uploadResult ul li span{
    	
    }
    .bigPictureWrapper{
    	position: absolute;
    	display: none;
    	justify-content: center;
    	align-items: center;
    	top: 0%;
    	width: 100%;
    	height: 100%;
    	background-color: gray;
    	z-index: 100;
    	background: rgba(255,255,255,0.5);
    }
    .bigPicture{
    	position: relative;
    	display: flex;
    	justify-content: center;
    	align-items: center;
    }
    .bigPicture img{
		width:600px;    
    }
    </style>
    
                   <!-- Begin Page Content --> 	
                   <div class="container-fluid">
                   		
                   		<!-- Page Heading -->
                   		<p class="mb-4">게시글 보기</p>
                   		
                   		<!-- DataTales Example -->
                   		<div class="card shadow mb-4">
                   			<div class="bigPictureWrapper">
                   				<div class="bigPicture">
                   				</div>
                   			</div>
                   			
                   			<div class="card-header py-3"></div>
                   			
                   			<div class="card-body">
	                   			<div class="form-group">
	                   				<label>제목</label> <input class="form-control" value='<c:out value="${bvo.btitle}" />' readonly>
	                   			</div>
	                   			
	                   			<div class="form-group">
	                   				<label>내용</label> <textarea class="form-control" readonly><c:out value="${bvo.bcontent}" /></textarea>
	                   			</div>
	                   			
	                   			<div class="form-group">
	                   				<label>작성자</label> <textarea class="form-control" readonly><c:out value="${bvo.bid }" /></textarea>
	                   			</div>
	                   			
	                   			<div class="form-group">
	                   				<label>작성일</label> <input class="form-control" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${bvo.bregdate}" />' readonly>
	                   			</div>     
	                   			
	                   			<form id='operForm' method="get">
	                   				<!-- 페이지,검색 내용 추가 -->
	                   				
	                   				<sec:authentication property="principal" var="pinfo" />
	                   				<sec:authorize access="isAuthenticated()">
	                   					<c:if test="${pinfo.username eq bvo.bid }">
	                   						<button type="submit" data-oper='edit' class="btn btn-primary">수정/삭제</button>
	                   					</c:if>
	                   				</sec:authorize>
	                   				
	                   				<button type="submit" data-oper='list' class="btn btn-primary">목록으로</button>
	                   				<input type="hidden" name="bno" value='<c:out value="${bvo.bno}"/>'>
	                   			</form>
                   			</div> <!-- end of card-body -->           			
                   		</div> <!-- end of card -->
                   		
                   		<!-- 첨부파일 -->
                   		<div class="card shadow mb-4">
                   			<div class="card-header py-3">
                   				<h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                   			</div>
                   			
                   			<div class="card-body">
                   				<div class="uploadResult">
                   					<ul></ul>
                   				</div>
                   			</div>
                   		</div>
                   		
                   		<!-- 댓글 추가 -->
                   		
                   </div> <!-- end of container-fluid -->
                   
<%@include file="../includes/footer.jsp" %>                  

<!-- 스크립트 -->
<script>
	$(document).ready(function(){
		
		//버튼 이벤트
		var of = $("#operForm");
		
		$("button[data-oper='edit']").on("click", function(e){
			of.attr("action", "/board2/edit").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			//of.find("#bno").remove();
			of.attr("action", "/board2/list").submit();
		});
		
		//첨부파일 보여주기
		var bno = '<c:out value="${bvo.bno}" />';
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
			console.log("arr확인 : " + arr);
			
			var str = "";
			$(arr).each(function(i, attach){
   				if(attach.fileType){
   					var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
   					
   					str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid;
   					str += "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
   					str += "<img src='/display?fileName=" + fileCallPath + "'>";
   					str += "</div></li>";
   				}else{
   					str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid;
   					str += "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
   					str += "<span> " + attach.fileName + "</span><br>";
   					str += "</div></li>";
   				}
			});
			
			$(".uploadResult ul").html(str);
		});
		
		//첨부파일 클릭시
		$(".uploadResult").on("click", "li", function(e){
			console.log("첨부파일 클릭");
			
			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g), "/"));
			}else{
				//이미지 아닐 경우 다운로드
				self.location = "/download?fileName=" + path;
			}
		});
		
		//원본 이미지창 닫기
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			
			setTimeout(function(){$('.bigPictureWrapper').hide();}, 1000);
		});
	}); //end of ready함수
	
	
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({width: '100%', height: '100%'}, 1000);
	}

</script>
</body>
</html>