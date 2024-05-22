<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$(document).ready(function(){
		
		var boardNum = Number("${boardNum}") + 1;
		
		var formDataJson = $('#boardWrite').serializeObject();
		console.log('formDataJson', formDataJson)
		
		$("#submit").on("click",function(){
			
			var formData = {};
			var formDataArray = $('.boardWrite :input ').serializeArray();

 			/* console.log(formDataArray.length);
			console.log(formDataArray); */
			
			formDataArray.forEach(function(item){
				if (formData[item.name]) {
					if (!Array.isArray(formData[item.name])) {
						formData[item.name] = [formData[item.name]];
					}
					formData[item.name].push(item.value);
				} else {
					formData[item.name] = item.value;
				}
			})
			
			
/* 			console.log("formData", formData); */
			
			if(formDataArray.length == 3){
				
				$.ajax({
				    url : "/board/boardWriteAction.do",
				    dataType: "json",
				    type: "POST",
				    data : formData,
				    success: function(data, textStatus, jqXHR)
				    {
						alert("작성완료");
						alert("메세지:"+data.success);
						location.href = "/board/boardList.do?pageNo=" + data.pageNo;
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				    
				    
				});
				
			}else{
				
				$.ajax({
				    url : "/board/manyBoardWriteAction.do",
				    dataType: "json",
				    type: "POST",
				    contentType: "application/json; charset=UTF-8",
				    data : JSON.stringify(formData),
				    success: function(data, textStatus, jqXHR)
				    {
						alert("작성완료");
						alert("메세지:"+data.success);
						location.href = "/board/boardList.do?pageNo=" + data.pageNo;
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				    
				    
				});
				
				
				
			}

		});
				
		
		$("#addRow").on("click", function(){	
		
		var str = "";
		
		/* str += "<tr>"
		str += 	"<td>"
		str += 		"<table border ='1'>" */
		str += 			"<tr>"
		str += 				"<td width='120' align='center'>"
 		str +=				"<input type='checkbox' id='checkBox' name='checkBox'/>"
		str += 				"Title"
		str += 				"</td>"
		str += 				"<td width='400'>"
		str += 				"<input name='boardTitle' type='text' size='50' value='${board.boardTitle}'> "
		str += 				"</td>"
		str += 			"</tr>"
		str += 			"<tr>"
		str += 				"<td height='300' align='center'>"
		str += 				"Comment"
		str += 				"</td>"
		str += 				"<td valign='top'>"
		str += 				"<textarea name='boardComment'  rows='20' cols='55'>${board.boardComment}</textarea>"
		str += 				"</td>"
		str += 			"</tr>"
		str +=          "<input type='hidden' name='boardNum' value='" + boardNum++ + "'>";
		/* str += 			"<tr>"
		str += 				"<td align='center'>"
		str += 				"Writer"
		str += 				"</td>"
		str += 				"<td>"
		str += 				"</td>"
		str += 			"</tr>"
		str += 		"</table>"
		str += 	"</td>" 
		str += "</tr>"*/
		
		$("#addplace").append(str);
		console.log($("#mainTable tbody tr").length)
		
		var formDataArray = $('.boardWrite :input').serializeArray();
		console.log(formDataArray);
		
		
		});
		
		$("#deleteRow").on("click", function(){
			
			/* if($("input[name=mainCheckBox]:checked")){
				$(this).closest("tr").next().remove(); 
	            $(this).closest("tr").remove();
			} */ /* 메인까지 삭제 일단 보류 */
			
			 $("input[name=checkBox]:checked").each(function (){
		            var $checkboxRow = $(this).closest("tr");
		            var $commentRow = $checkboxRow.next();
		            $checkboxRow.remove();
		            $commentRow.remove();
		      });
			
	    });

			
		
	});
	

</script>
<body>
<form class="boardWrite" id="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
				<input id="addRow" name="addRow" type="button" value="행추가">
				<input id="deleteRow" name="deleteRow"  type="button" value="행삭제">
				<input id="submit" name="submit"  type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
			<input type='hidden' name='boardNum' value='${boardNum}'>
				<table id="mainTable" border ="1"> 
					<tr>
						<td width="120" align="center">
						<!-- <input type="checkbox" id="mainCheckbox" name="mainCheckbox"/> -->
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
					<tbody id="addplace"></tbody>
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