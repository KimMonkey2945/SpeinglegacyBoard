<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">

	$(document).ready(function(){
		
		var frm = $('.boardUpdate :input');
		var param = frm.serialize();
// 		console.log(param);

		$("#submit").on("click",function(){
			
			var frm = $('.boardUpdate :input');
			var param = frm.serialize();
			
			var updateBoardType = $("select[name=boardType]").val();
// 			console.log(updateBoardType);
			
			
			var boardType = '${board.boardType}';
			var boardNum = ${board.boardNum};
			console.log(param);
			console.log(boardType);

			$.ajax({
			    url : "/board/" + boardType + "/" + boardNum + "/" + updateBoardType +  "/boardUpdate.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
// 			    	console.log(data)
					alert("수정완료");
					alert("메세지:"+data.success);
					location.href ="/board/" + updateBoardType + "/" + boardNum + "/boardView.do"
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
<form class="boardUpdate">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="수정">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
							Type
						</td>
						<td width="400">
							<select id="boardType" name="boardType">
							<c:forEach items='${code}' var='code'>
								<option value="${code.codeId}">${code.codeName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
				
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>		
</body>
</html>