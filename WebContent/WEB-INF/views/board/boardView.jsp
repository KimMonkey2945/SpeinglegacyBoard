<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#delete").on("click",function(){
			
			var boardType = ${board.boardType};
			var boardNum = ${board.boardNum};
			var $frm = $('.boardDelete :input');
			var param = $frm.serialize();

			console.log(boardNum);
			console.log(boardType);

			$.ajax({
			    url : "/board/" + boardType + "/" + boardNum + "/boardDelete.do",
			    dataType: "JSON",
			    type: "POST",
			    data : param,
			    success: function(data,textStatus, jqXHR)
			    {
			    	console.log(data);
			    	if(data.resultCnt == 0){
			    		alert("이미 삭제된 게시물입니다.")
			    	}else{
			    		alert("삭제완료")
			    	}
			    	location.href = "/board/boardList.do"
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
		
	});
	

</script>
<body>
<form class="boardDelete">
	<table align="center">
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
								Type
						</td>
						<td width="400">
							<select id="boardType" name="boardType">
								<option value="${board.boardType}">${board.code.codeName}</option>
							</select>
						</td>
						</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						${board.boardTitle}
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td>
						${board.boardComment}
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>${board.creator}</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<table align="center" style="border-spacing:10px; border-collapse:separate;">
	<tr>
		<td>
			<%-- <a onclick="javascript:sendPost()" id="delete" href="/board/${board.boardType}/${board.boardNum}/boardDelete.do">delete</a> --%>
			<input id="delete" type="button" value="delete" />
		</td>
		<td style="width:30px;"></td>
		<td>
			<a href="/board/${board.boardType}/${board.boardNum}/boardUpdateView.do?pageNo=${pageNo}">update</a>
		</td>
		<td style="width:30px;"></td>
		<td>
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>
</form>	
</body>
</html>