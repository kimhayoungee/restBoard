/**
 * 
 */
 
console.log("Reply Module ");
 
var replyService = (function(){

	function add(reply, callback, error){
		console.log("댓글 등록 ");
		
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
	
	function edit(){
		
	
	} //end of edit함수
	
	function remove(rno, callback, error){
		$.ajax({
			 type : 'get'
			,url  : '/reply/remove/' + rno
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
	
	} //end of remove
	
	return {
		 add : add
		,getList : getList
			
		,remove : remove
	};
})();