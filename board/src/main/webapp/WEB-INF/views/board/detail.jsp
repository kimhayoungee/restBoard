<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>     
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  

<!DOCTYPE html>
<html lang="en">

<head>
	<title>게시글 보기</title>
	<%@include file="../includes/header.jsp" %>
    <script type="text/javascript" src="/resources/js/reply.js"></script>
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
    
    <script>
    $(document).ready(function(){
    	
    	
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
    	
      
        //버튼이벤트
        var operForm = $("#operForm");
        
		$("button[data-oper='edit']").on("click", function(e){
			
			operForm.attr("action", "/board/edit").submit();
			
		});
		
		$("button[data-oper='list']").on("click", function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list").submit();
			
		});
		
		//댓글
		var bnoVal = '<c:out value="${bvo.bno}" />';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(pageNum){
			replyService.getList({bno:bnoVal, pageNum:pageNum||1}, function(replyCnt, list){
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				console.log(list);
				
				if(pageNum == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str="";
		/*  		if(list==null || list.length==0){
					return;
				}  */
				
				for(var i=0, len=list.length||0; i<len; i++){
					str += "<li data-rno='" + list[i].rno + "'>";
					str += "<div><div><strong class='primary-font'>" + list[i].rid +"</strong>";
					str += "<small>&nbsp;&nbsp;&nbsp;" + replyService.displayTime(list[i].replydate) + "</small></div>";
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
				showReplyPage(replyCnt);
			})
			
		} //end of showList(page)
		
		//모달창
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputRid = modal.find("input[name='rid']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalEditBtn = $("#modalEditBtn");
		var modalRemoBtn = $("#modalRemoBtn");
		var modalRegiBtn = $("#modalRegiBtn");
		var modalCloseBtn = $("#modalCloseBtn");
		
		var replyer = null;
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username" />';
		</sec:authorize>
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		//댓글 제목 클릭시 상세조회
		$(".chat").on("click", "li", function(e){
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputRid.val(reply.rid);
				modalInputReplyDate.val(replyService.displayTime(reply.replydate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalEditBtn.show();
				modalRemoBtn.show();
				
				modal.modal("show");
				
			});
		});		
		
		//Ajax spring security header
		$(document).ajaxSend(function(e, xhr, options){
			
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			
		});		
		//등록 모달창 켜는 버튼
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modal.find("input[name='rid']").val(replyer);
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalInputReplyDate.closest("div").hide();
			modalRegiBtn.show();
			
			modal.modal("show");
			
		});
		
		//모달창 내 등록버튼
		modalRegiBtn.on("click", function(e){
			var reply = {reply:modalInputReply.val(), rid:modalInputRid.val(), bno:bnoVal};
			
			replyService.add(reply, function(result){
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1);
			});
		});
		
		//모달창 내 수정버튼
		modalEditBtn.on("click", function(e){
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			
			replyService.edit(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
			
		});
		
		//모달창 내 삭제버튼
		modalRemoBtn.on("click", function(e){
			var rno = modal.data("rno");
			
			console.log("rno: " + rno);
			console.log("replyer: " + replyer);
			
			if(!replyer){
				alert("로그인 후 삭제가 가능합니다");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = modalInputRid.val();
			console.log("Original Replyer: " + originalReplyer);
			
			if(replyer !=originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			replyService.remove(rno, originalReplyer, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
				
			});
		});
		
		//댓글페이징
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum -9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum *10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum *10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='" + (startNum-1) + "'>Previous</a></li>";
				
			}
			
			for(var i=startNum; i<=endNum; i++){
				var active = pageNum == i? "active" : "";
				
				str += "<li class='page-item" + active + "'><a class='page-link' href='" + i +"'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum+1) + "'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			replyPageFooter.html(str);
		}
		
		//페이지 번호 클릭시
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("클릭한 페이지 번호 : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
			
		});
		
		//첨부파일 클릭시 
		$(".uploadResult").on("click", "li", function(e){
			console.log("이미지 보여주기");
			
			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g), "/"));
				
			}else{
				//다운로드
				self.location = "/download?fileName=" + path;
			}
		});
		
		//원본 이미지창 닫기
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			
			setTimeout(function(){$('.bigPictureWrapper').hide();}, 1000);
		});
		
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
        		,dataType: 'json'
        		,success: function(result){
        			console.log(result);
        			showUploadResult(result);
        		}
        	});
        	
        });		
    }); //end of ready함수
    
    function showImage(fileCallPath){
    	alert(fileCallPath);
    	
    	$(".bigPictureWrapper").css("display", "flex").show();
    	
    	$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath +"'>")
    	 .animate({width: '100%', height: '100%'}, 1000);
    }
    </script>
    
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
                    <p class="mb-4">게시글 보기</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                    	<div class="bigPictureWrapper">
                    		<div class="bigPicture">
                    		</div>
                    	</div>
                    	
                        <div class="card-header py-3">
		       
                        </div>
                        <div class="card-body">
                       
                       	<div class="form-group">
                       		<label>제목</label> <input class="form-control" value='<c:out value="${bvo.btitle}"/>' readonly>
                       	</div>
                       	
                       	<div class="form-group">
                       		<label>내용</label> <textarea class="form-control" readonly><c:out value="${bvo.bcontent}"/></textarea>
                       	</div>
                        
                     	<div class="form-group">
                       		<label>작성일</label> <input class="form-control" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${bvo.bregdate}"/>' readonly>
                       	</div>                        
                        	
                         <form id='operForm' action="/board/edit" method="get">	
                        	<input type="hidden" name='bno' value='<c:out value="${bvo.bno}"/>'>
                        	<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                        	<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
                        	<input type="hidden" name='type' value='<c:out value="${cri.type}"/>'>
                        	<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}"/>'>
                        	
                        	<sec:authentication property="principal" var="pinfo" />
                       		<sec:authorize access="isAuthenticated()">
                        		<c:if test="${pinfo.username eq bvo.bid}">
                        			<button type="submit" data-oper='edit' class="btn btn-primary">수정/삭제</button>
                        		</c:if>
                       		</sec:authorize>
                       		
                        	<button type="submit" data-oper='list' class="btn btn-primary">목록으로</button>
                        </form>
                        </div>
                    </div>
                    
                    <!-- 첨부파일 -->
                    <div class="card shadow mb-4">
                    	<div class="card-header py-3">
                    		<h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                    	</div>
                    	
                    	<div class="card-body">
                    		<div class="uploadResult">
                    			<ul>
                    			</ul>
                    		</div>
                    	
               			</div>
                    </div>
                    
                    <!-- 댓글 -->
					<div class="card shadow mb-4">
						<!-- 댓글 헤더 -->
						<div class="card-header py-3">
							<i class="fa fa-comments fa-fw"></i> Reply &nbsp;&nbsp;
							
							<sec:authorize access="isAuthenticated()"> 
								<button id='addReplyBtn' class='btn btn-outline-primary'>댓글 작성</button>
							</sec:authorize>
						</div>
						
						<!-- 댓글목록 -->
						<div class="card-body">
							<ul class="chat">
			
							</ul>
						</div>
						
						<!-- 댓글페이징 -->
						<div class="panel-footer">
						
						</div>
					</div>
					<!-- end of 댓글 card -->
					
					<!-- 댓글 modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
								</div>
								
								<div class="modal-body">
									<div class="form-group">
										<label>댓글 내용</label>
										<input class="form-control" name='reply' value='New Reply!'>
									</div>
									<div class="form-group">
										<label>작성자</label>
										<input class="form-control" name='rid' value='rid'>
									</div>
									<div class="form-group">
										<label>작성일</label>
										<input class="form-control" name='replyDate' value=''>
									</div>
								</div>
								
								<div class="modal-footer">
									<button id="modalEditBtn" type="button" class="btn btn-warning">수정</button>
									<button id="modalRemoBtn" type="button" class="btn btn-danger">삭제</button>
									<button id="modalRegiBtn" type="button" class="btn btn-primary">등록</button>
									<button id="modalCloseBtn" type="button" class="btn btn-primary">닫기</button>
								</div> 
							</div>
						</div>
					</div>
					<!-- end of 댓글 modal -->
					
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