<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">


	$(document).ready(function(){
		
		
		$('#checkAll').on('click', function(){
			if($('#checkAll').is(':checked')){
				$('input[name="boardType"]').prop('checked', true);	
			} else {
				$('input[name="boardType"]').prop('checked', false);
			}
			
		});
		
		$('#search').on('click', function(){
			var checkValues = [];
			
			
			$('input[name="boardType"]:checked').each(function(){
				checkValues.push($(this).val());
			});
			
			console.log(checkValues);
			
			if(checkValues.length == 0){
			 $('input[name="boardType"]').each(function(){
	                checkValues.push($(this).val());
	           });	
			}
			
			 var data = {boardTypes: checkValues, pageNo: 1};
					
			
			$.ajax({
	            url: '/board/filteredBoardList.do',
	            type: 'POST',
	            data: JSON.stringify(data),
	            contentType: 'application/json',
	            success: function(response) {
	            	
	                // 서버로부터 데이터를 받아서 화면에 출력
	                var table = $('#boardTable');
	                var totalCnt = data.totalCnt;
	                
	                console.log(totalCnt);
	                $('#totalCnt').html('total : ' + response.totalCnt);
	                table.find('tr:gt(0)').remove(); // 헤더 제외한 기존 데이터 삭제
	                
	                $.each(response.boardList, function(index, list) {
	                    table.append(
	                        '<tr>' +
	                        '<td align="center">' + list.code.codeName + '</td>' +
	                        '<td>' + list.boardNum + '</td>' +
	                        '<td><a href="/board/' + list.boardType + '/' + list.boardNum + '/boardView.do?pageNo=' + 1 + '">' + list.boardTitle + '</a></td>' +
	                        '</tr>'
	                    );
	                });
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                alert('실패');
	            }
	        });
			
			
		});
		
		
	});

</script>
<body>

<table align="center" style="border-spacing:10px; border-collapse:separate">
	<tr>
		<td id="totalCnt" align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.code.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
</table>
<table align="center" style="border-spacing:30px; border-collapse:separate">
	<tr>
		<td style="width:30px;"><input id="checkAll" type="checkbox">전체</td>
		<td style="width:30px;"><input type="checkbox" name="boardType" value="a01">일반</td>
		<td style="width:30px;"><input type="checkbox" name="boardType" value="a02">Q&A</td>
		<td style="width:30px;"><input type="checkbox" name="boardType" value="a03">익명</td>
		<td style="width:30px;"><input type="checkbox" name="boardType" value="a04">자유</td>
		<td style="width:30px;"><input id="search" type="submit" value="조회"></td>
		<td align="right"><a href ="/board/boardWrite.do">글쓰기</a></td>
	</tr>
</table>
</body>
</html>