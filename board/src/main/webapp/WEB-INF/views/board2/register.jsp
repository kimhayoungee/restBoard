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
		var rf = $('#regForm');
		
		$("#regBtn").on("click", function(e){
			e.preventDefault();
			console.log("submit 클릭");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				
				console.dir(jobj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid value='" + jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
			});
			rf.attr("action", "/board2/register");
			rf.append(str).submit();
			
		}); //end of #regBtn click
		
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
		
		//첨부파일 추가시 ajax 
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
		}); //enf of input file change
		
		//첨부파일 변경시 ajax
		$(".uploadResult").on("click", "button", function(e){
			console.log("파일 삭제");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			
			$.ajax({
				 url: '/deleteFile'
				,data: {fileName: targetFile, type: type}
				,beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
 				 }
				,dataType: 'text'
				,type: 'POST'
				,success: function(result){
					targetLi.remove();
				 }
			
			});
		}); 
		
	});	//end of ready
	
	$("#listBtn").on("click", function(){
		
		$("#moveForm").attr("action", "/board2/list").submit();
		
	});
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length ==0) return;
		
		var uploadUL = $(".uploadResult ul");
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
		
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
		
	} //end of showUploadResult(arr)
	
	</script>
</body>
</html>