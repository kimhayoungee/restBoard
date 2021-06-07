<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>     
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<%@include file="../includes/header.jsp" %>


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
                  <!--   <h1 class="h3 mb-2 text-gray-800">게시글 쓰기</h1> -->
                    <p class="mb-4">게시글 수정</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                    	<div class='bigPictureWrapper'>
                    		<div class='bigPicture'>
                    		</div>
                    	</div>
                        
                        <div class="card-header py-3">
		       
                        </div>
                        <div class="card-body">
                        <form action="/board/edit" method="post">
                        
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
                        	<div class="form-group">
                        		<label>제목</label> <input class="form-control" name='btitle' value='<c:out value="${bvo.btitle}"/>' >
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label> <textarea class="summernote" name='bcontent'><c:out value="${bvo.bcontent}"/></textarea>
                        	</div>
                        	
                            <div class="form-group">
                       			<label>작성일</label> <input class="form-control" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${bvo.bregdate}"/>' >
                       		</div>  
                       		                 	
                        	<input type="hidden" name='bno' value='<c:out value="${bvo.bno}"/>'>
                        	<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                        	<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
                        	<input type="hidden" name='type' value='<c:out value="${cri.type}"/>'>
                        	<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}"/>'>
         
         					<sec:authentication property="principal" var="pinfo" />
         					<sec:authorize access="isAuthenticated()">
         						<c:if test="${pinfo.username eq bvo.bid}">
		                        	<button type="submit" data-oper='edit' class="btn btn-primary">수정</button>
		                        	<button type="submit" data-oper='remove' class="btn btn-primary">삭제</button>         							
         						</c:if>
         					</sec:authorize>	

                        	<button type="submit" data-oper='list' class="btn btn-primary">목록으로</button>
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

	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
   <script>
    $(document).ready(function(){
    	//첨부파일
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
    	
    	//서머노트
    	var toolbar = [
		    // 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 표만들기
		    ['table', ['table']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],

		];

		var setting = {
            height : 300,
            minHeight : null,
            maxHeight : null,
            focus : true,
            lang : 'ko-KR',
            toolbar : toolbar
        };

        $('.summernote').summernote(setting);
       
      //버튼이벤트
        var formObj = $("form");
        
        $('button').on("click", function(e){
        	
        	e.preventDefault();
        	
        	var operation = $(this).data("oper");
        	
        	console.log(operation);
        	
        	if(operation==='remove'){
        		
        		formObj.attr("action", "/board/remove");
        	
        	}else if(operation==='list'){
        		
         		formObj.attr("action", "/board/list").attr("method", "get");
        		var pageNumTag = $("input[name='pageNum']").clone();
        		var amountTag = $("input[name='amount']").clone();
        		var typeTag = $("input[name='type']").clone();
        		var keywordTag = $("input[name='keyword']").clone();
        		
        		formObj.empty();
        		
        		formObj.append(pageNumTag);
        		formObj.append(amountTag);
        		formObj.append(typeTag);
        		formObj.append(keywordTag);
        		

        		formObj.append(str).submit();
        	}else if(operation === 'edit'){
        		var str = "";
        		
        		$(".uploadResult ul li").each(function(i, obj){
        			var jobj = $(obj);
        			console.dir(jobj);
        			
        			str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
        			str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
        		});
        		formObj.append(str).submit();
        	}
        	formObj.submit();
        }); //end of 버튼클릭
        
        $(".uploadResult").on("click", "button", function(e){
        	console.log("파일 삭제버튼 클릭");
        	
        	if(confirm("이 파일을 삭제하시겠습니까?")){
        		var targetLi = $(this).closest("li");
        		targetLi.remove();
        	}
        });
        
        //
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 5242880 //5MB
        
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
        var csrfTokenValue="${_csrf.token}";
        
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
        		,data: formData
        		,type: 'POST'
        		,beforeSend: function(xhr){
        			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        		}
        		,dataType: 'json'
        		,success: function(result){
        			console.log(result);
        			showUploadResult(result);
        		}
        	});
        	
        });		        
    }); //end of ready
    </script>
</body>

</html>