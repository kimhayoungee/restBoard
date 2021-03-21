<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>     

<%@include file="../includes/header.jsp" %>
	<title>게시글 수정</title>
	
	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
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
    	color: white;
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
        
 

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">자유 게시판</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="index.html">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>Components</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Custom Components:</h6>
                        <a class="collapse-item" href="buttons.html">Buttons</a>
                        <a class="collapse-item" href="cards.html">Cards</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>Utilities</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Custom Utilities:</h6>
                        <a class="collapse-item" href="utilities-color.html">Colors</a>
                        <a class="collapse-item" href="utilities-border.html">Borders</a>
                        <a class="collapse-item" href="utilities-animation.html">Animations</a>
                        <a class="collapse-item" href="utilities-other.html">Other</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="login.html">Login</a>
                        <a class="collapse-item" href="register.html">Register</a>
                        <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="404.html">404 Page</a>
                        <a class="collapse-item" href="blank.html">Blank Page</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item active">
                <a class="nav-link" href="tables.html">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Tables</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">김하영</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                  <!--   <h1 class="h3 mb-2 text-gray-800">게시글 쓰기</h1> -->
                    <p class="mb-4">게시글 쓰기</p>

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
							<h6 class="m=0 font-weight-bold text-primary">첨부 파일</h6>
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