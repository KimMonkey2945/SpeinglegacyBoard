<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8" />
</head>
<script>

	$(document).ready(function(){
		
		
		$('#login').on('click', function(){
			
			var userId = $('#loginUserId').val();
			var userPw = $('#loginUserPassword').val();
			
			console.log( "userId : " , userId);
			console.log( "userPw : " , userPw);
			
			if(userId == ''){
				alert('아이디를 입력해주세요.');
				$('#loginUserId').focus();
				return false;
			}
			
			if(userPw == ''){
				alert('비밀번호를 입력해주세요.');
				$('#loginUserPassword').focus();
				return false;
			} 
			
			$.ajax({
				url: '/user/loginAction.do',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({userId: userId, userPw: userPw}),
				success: function(data){
					if(data.nullId){
						alert(data.nullId);
						return false;
					}else if(data.nullPassword){
						alert(data.nullPassword);
						return false;
					}
				 	alert("로그인 완료");
	                location.href = "/board/boardList.do";
				},
				error: function(e){
					alert("error");
				}
			});
			
		});
		
		$('#loginUserId').on('keyup', function(){
			this.value = this.value.replace(/[^0-9a-zA-Z]/g, '').substring(0,15);
			
		});
		
		$('#loginUserPassword').on('keyup', function(){
			this.value = this.value.replace(/[^0-9a-zA-Z]/g, '').substring(0,12);
		});
		
	});
	
	

</script>
<body>

	<form>
		
	<table align="center" style="border-spacing:10px; border-collapse:separate; border:1px solid black; width:300px">
		
		<tr>
			<td align="center" style="border:1px solid black; width:20%">id</td>
			<td>
				<input id="loginUserId" name="loginUserId"/>
			</td>
		</tr>
		<tr>
			<td align="center" style="border:1px solid black; width:20%">pw</td>
			<td>
				<input id="loginUserPassword" name="loginUserPassword" type="password"/>
			</td>
		</tr>
	
	</table>
		<div style="text-align: right; width:910px; margin-top:5px">
			<input id="login" type="button" value="login"/>
		</div>
	</form>


</body>
</html>