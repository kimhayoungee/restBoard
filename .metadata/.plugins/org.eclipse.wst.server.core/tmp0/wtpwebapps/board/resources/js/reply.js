/**
 * 
 */
 
console.log("Reply Module ");
 
var replyService = (function(){

	function add(reply, callback, error){
		console.log("댓글 등록 js ");
		
		$.ajax({
			 type: 'post'
			,url : '/reply/register'
			,data: JSON.stringify(reply)
			,contentType: "application/json; charset=utf-8"
			,success: function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			 }
			,error: function(xhr, status, er){
				if(error){
					error(er);
				}
			 }
		});
	} // end of add함수
		
	function getList(param, callback, error){
		console.log("댓글 전체 조회 js");
		
		var bno = param.bno;
		var pageNum = param.pageNum || 1;
		
		$.getJSON("/reply/page/" + bno + "/" + pageNum + ".json"
			,function(data){
				if(callback){
					callback(data);
				}
			}
		).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	} //end of getList함수
	
	function edit(reply, callback, error){
		console.log("댓글 수정 js " + reply.rno);
		
		$.ajax({
			 type: 'post'
			,url : '/reply/edit'
			,data: JSON.stringify(reply)
			,contentType: "application/json; charset=utf-8"
			,success: function(result, status, xhr){
			 	if(callback){
			 		callback(result);
			 	}
			 }
			,error: function(xhr, status, er){
				if(error){
					error(er);
				}
			 }
		});
	} //end of edit함수
	
	function remove(rno, callback, error){
		console.log("댓글 삭제 js");
		
		$.ajax({
			 type : "get"
			,url  : "/reply/remove/" + rno
			,success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			 }
			,error : function(xhr, status, er){
				if(error){
					error(er);
				}
			 } 
		});
	} //end of remove 함수
	
	function get(rno, callback, error){
		console.log("댓글 조회? ");
		
		$.get("/reply/" + rno + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	} //end of get 함수
	
	return {
		 add : add
		,getList : getList
		,edit : edit
		,remove : remove
		,get : get
	};
})();