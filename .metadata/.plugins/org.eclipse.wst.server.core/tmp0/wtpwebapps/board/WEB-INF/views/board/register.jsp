<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">

<head>
	<%@include file="../includes/header.jsp" %>
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
        var formObj = $("form[role='form']");
        
        $("button[type='submit']").on("click", function(e){
        	
        	e.preventDefault();
        	
        	console.log("submit 클릭");
        	
        	var str = "";
        	
        	$(".uploadResult ul li").each(function(i, obj){
        		var jobj = $(obj);
        		console.dir("확인 : " + jobj);
        		
        		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+ jobj.data("filename") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
        		str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
        		
        		formObj.append(str).submit();
        	})
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

	<title>게시글 작성</title>
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
                        <div class="card-header py-3">
		       				<h6 class="m-0 font-weight-bold text-primary">게시글 작성</h6>
                        </div>
                        <div class="card-body">
                        <form action="/board/register" method="post">
                        	<div class="form-group">
                        		<label>제목</label> <input class="form-control" name='btitle'>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label> <textarea class="summernote" name='bcontent'></textarea>
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
</body>

</html>