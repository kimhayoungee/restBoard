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
					callback(data.replyCnt, data.list);
				}
			}
		).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	} //end of getList함수
	
	function edit(reply, callback, error){
		console.log("댓글 수정 js " + reply.rno + " : " + reply.replyer);
		
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
	
	function remove(rno, replyer, callback, error){
		console.log("댓글 삭제 js");
		var url = "/reply/remove/" + rno;
		var encodedUrl = encodeURI(url);
		
		$.ajax({
			 type : "post"
			,url  : encodedUrl
			,data : JSON.stringify({rno:rno, rid:replyer})
			,contentType: "application/json; charset=utf-8"   
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
	
	function displayTime(timeValue){
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh>9? '' : '0') + hh, (mi>9? '' : '0') + mi, (ss>9? '' : '0') + ss].join(':');
		}else{
			var yy = dateObj.getFullYear();
			var mm = parseInt(dateObj.getMonth(),10) + 1;
			var dd = dateObj.getDate();

			return [yy, (mm>9? '' : '0') + mm, (dd>9? '' : '0') + dd].join('/');
		}
	}
	
	
	return {
		 add : add
		,get : get
		,getList : getList
		,edit : edit
		,remove : remove
		,displayTime : displayTime
	};
})();