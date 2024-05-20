<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#delete").on("click",function(){
			
			var boardType = ${board.boardType};
			var boardNum = ${board.boardNum};
			
			console.log(boardType);
			console.log(boardNum);

			$j.ajax({
			    url : "/board/" + boardType + "/" + boardNum + "/boardDelete.do",
			    dataType: "json",
			    type: "POST",
			    data : data,
			    success: function(data, textStatus, jqXHR)
			    {
			    	alert("삭제성공")
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
<table align="center">
	<tr>
		<td>
			<table border ="1">
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
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td align="left">
			<a href = "/board/${board.boardType}/${board.boardNum}/boardUpdateView.do?pageNo=${pageNo}">update</a>
		</td>
		<td align="center">
			<a id="delete" href="/board/${board.boardType}/${board.boardNum}/boardDelete.do">delete</a>
		</td>
		<td align="right">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	
</body>
</html>