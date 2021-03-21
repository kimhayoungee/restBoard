<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   

<%@include file="../includes/header.jsp" %>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                  <!--   <h1 class="h3 mb-2 text-gray-800">게시글 쓰기</h1> -->
                    <p class="mb-4">게시글 쓰기</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
		       				<h6 class="m-0 font-weight-bold text-primary">게시글 작성</h6>
                        </div>
                        <div class="card-body">
                        	<form action="/board/register" method="post" id="regForm">
                        	
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        	<div class="form-group">
                        		<label>제목</label> <input class="form-control" name='btitle'>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label> <textarea class="summernote" name='bcontent'></textarea>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label> <input class="form-control" name='bid' value='<sec:authentication property="principal.username" />' readonly>
                        	</div>
                        	
                        	<button type="submit" class="btn btn-primary">등록</button>
                        	<button type="reset" class="btn btn-primary">취소</button>
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

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

	<%@include file="../includes/footer.jsp" %>
	
	
<!-- 스크립트 -->

	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    
    <script>
    $(document).ready(function(){
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
        
        //첨부파일
        //등록 클릭시 기본동작 막기
       /*  var formObj = $("form[role='form']"); */
       var formObj = $('#regForm');
        
        $("button[type='submit']").on("click", function(e){
        	
        	e.preventDefault();
        	
        	console.log("submit 클릭");
        	
        	var str = "";
        	
        	$(".uploadResult ul li").each(function(i, obj){
        		var jobj = $(obj);
        		
        		console.dir(jobj);
        		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+ jobj.data("filename") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
        		
        	});
        	formObj.append(str).submit();
        	
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
        
        //첨부파일 변경
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
        			alert(result);
        			targetLi.remove();
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
    			str += "<img src='/resources/img/attach.png'></a>";
    			str += "</div>";
    			str += "</li>";
    		}
    	});
    	
    	uploadUL.append(str);
    }

    </script>

</body>

</html>