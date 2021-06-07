<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<%@ include file="../includes/header.jsp" %>

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
               		<p class="mb-4">---</p>
               		
               		<div class="card shadow mb-4">
               		
               			<div class="card shadow mb-4">
               				<div class='bigPictureWrapper'>
               					<div class='bigPicture'></div>
               				</div>
               			</div>
               			<div class="card-header py-3"0>
               				<h6 class="m-0 font-weight-bold text-primary">게시글 수정</h6>
               			</div> 
               			
               			<div class="card-body">
               				<form action="/board2/edit" method="post">
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
	                        	
	                        	<sec:authentication property="principal" var="pinfo" />
	                        	<sec:authorize access="isAuthenticated()">
	                        		<c:if test="${pinfo.username eq bvo.bid }">
			                        	<button type="submit" data-oper='edit' class="btn btn-primary">수정</button>
			                        	<button type="submit" data-oper='remove' class="btn btn-primary">삭제</button>
		                        	</c:if>
	                        	</sec:authorize>
	                        	
                        		<input type="hidden" name='bno' value='<c:out value="${bvo.bno}"/>'>
								<button type="submit" data-oper='list' class="btn btn-primary">목록으로</button>
                        	</form>

               			</div> <!-- end of card-body -->               			               			
               		</div> <!-- end of card --> 
               		
               		<!-- 첨부파일 -->
                    <div class="card shadow mb-4">
               			<div class="card-header py-3">
               				<h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
               			</div>
               			
               			<div class="card-body">
               				<div class="form-group uploadDiv">
               					<input type="file" name='uploadFile' multiple>
               				</div>
               				
               				<div class='uploadResult'>
               					<ul></ul>
               				</div>
               			</div>
               		</div>
               		
				</div> <!-- end of container-fluid -->  		   

<%@include file="../includes/footer.jsp" %>

<!-- 스크립트 -->
<script>
	$(document).ready(function(){
    	var bno = '<c:out value="${bvo.bno}" />';
    	$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
    		console.log(arr);
    		var str = "";
    		
    		$(arr).each(function(i, attach){
    			if(attach.fileType){
    				var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
    				
    				str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid;
    				str += "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
    				str += "<span> " + attach.fileName + "</span>";
    				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' ";
    				str += "class='btn btn-warning stn-circle'><i class='far fa-times-circle'></i></button><br>";
    				str += "<img src='/display?fileName=" + fileCallPath + "'>";
    				str += "</div></li>";
    				
    			}else{
    				str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid;
    				str += "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
    				str += "<span> " + attach.fileName + "</span><br>";
    				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' ";
    				str += "class='btn btn-warning btn-circle'><i class='far fa-times-circle'></i></button><br>";
    				str += "</div></li>";
    			}	
    		});
    		
    		$(".uploadResult ul").html(str);
    	}); //end of getJSON
    			
		//버튼이벤트
		var formObj = $("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			
			var op = $(this).data("oper");
			console.log(op);
			
			if(op==='remove'){
				
				formObj.attr("action", "/board2/remove");
				
			}else if(op==='list'){
				
				formObj.attr("action", "/board2/list").attr("method","get");
				
				//검색조건
				
			}else if(op==='edit'){
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					
        			str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
				});
				formObj.append(str);
			}
			
			formObj.submit();
		});
		
        //첨부파일 변경
        $(".uploadResult").on("click", "button", function(e){
        	console.log("파일 삭제버튼 클릭");
        	
        	if(confirm("이 파일을 삭제하시겠습니까?")){
        		var targetLi = $(this).closest("li");
        		targetLi.remove();
        	}
        });			
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 3145728; //3MB
		
        function chkExtension(fileName, fileSize){
        	if(fileSize >=maxSize){
        		alert("파일 크기 초과");
        		return false;
        	}
        	
        	if(regex.test(fileName)){
        		alert("해당 종류의 파일은 업로드할 수 없습니다");
        		return false;
        	}
        	return true;
        }
		
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";
		 
        //첨부파일 추가
        $("input[type='file']").change(function(e){
        	var formData = new FormData();
        	var inputFile = $("input[name='uploadFile']");
        	var files = inputFile[0].files;
        	
        	for(var i=0;i<files.length;i++){
        		if(!chkExtension(files[i].name, files[i].size)){
        			return false;
        		}
        		formData.append("uploadFile", files[i]);
        	}
        	
        	$.ajax({
        		 url: '/uploadAjaxAction'
        		,processData: false
        		,contentType: false
        		,beforeSend: function(xhr){
        			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        		}
        		,data: formData
        		,type: 'POST'
        		,dataType: 'json'
        		,success: function(result){
        			console.log(result);
        			showUploadResult(result);
        		}
        	});
        	
        });



	}); //end of ready
	
	
    function showUploadResult(uploadResultArr){
    	if(!uploadResultArr || uploadResultArr.length==0){ return; }
    	
    	var uploadUL = $(".uploadResult ul");
    	var str = "";
    	
    	$(uploadResultArr).each(function(i, obj){
    		//image type
    		if(obj.image){
    			var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
    			str += "<li data-path='" + obj.uploadPath +"'";
    			str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'";
    			str += "><div>";
    			str += "<span> " + obj.fileName + "</span>";
    			str += "<button type='button' data-file=\'" + fileCallPath + "\' "
    			str += "data-type='image' class='btn btn-warning btn-circle'><i class='far fa-times-circle'></i></button><br>";
    			str += "<img src='/display?fileName=" + fileCallPath + "'>";
    			str += "</div>";
    			str += "</li>";
    		}else{
    			var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
    			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
    			
    			str += "<li data-path='" + obj.uploadPath + "'"; 
    			str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'";
    			str += "><div>";
    			str += "<span> " + obj.fileName + "</span>";
    			str += "<button type='button' data-file=\'" + fileCallPath + "\' "
    			str += "data-type='file' class='btn btn-warning btn-circle'><i class='far fa-times-circle'></i></button><br>";
    			str += "<img src='/resources/img/attach.png' alt=''></a>";
    			str += "</div>";
    			str += "</li>";
    		}
    	});
    	
    	uploadUL.append(str);
    }
</script>

</body>
</html>