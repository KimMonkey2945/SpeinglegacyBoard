<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta charset="UTF-8" />
</head>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script>

	jQuery.fn.serializeObject = function() {
	    var obj = {};
	    var form = this[0];
	    var formData = new FormData(form);
	    formData.forEach(function(value, key) {
	        if (obj[key] !== undefined) {
	            if (!Array.isArray(obj[key])) {
	                obj[key] = [obj[key]];
	            }
	            obj[key].push(value);
	        } else {
	            obj[key] = value;
	        }
	    });
	    return obj;
	};


	$(document).ready(function(){
		
		 var userIdCheckedAgain = false;
		
		$("#join").on("click", function(){
			
			var frm = $("#signUp :input");
			var param = frm.serialize();
			console.log(param);
			
// 			var formDataJson = $("#signUp").serializeObject();
// 			console.log(formDataJson);
			
			var userId = $('#userId').val();
			
/* 			if else (){
				
			} */
			
			// 필수값 통짜 검증을 위한			
			var requiredInputs = $(".required");
			
			var emptyRequired = requiredInputs.filter(function(){
				return !this.value;
			});
			
			if(userId == ""){
				alert("아이디를입력해주세요.")
				$('#userId').focus();
				return false;
			}
			
			if(!userIdCheckedAgain){
				alert("아이디 중복 확인을 해주세요.")
				$('#userId').focus();
                return false;
			}
			
			if(userId == ""){
				alert("아이디를입력해주세요.")
				$('#userId').focus();
				return false;
			}
			
			// 비밀번호길이, 전화번호, 우편번호
			var pw =  $('#userPw').val();
			var userPwCheck = $('#userPwCheck').val();
			var userName = $('#userName').val();
			var userPhone2 = $('#userPhone2').val();
			var userPhone3 = $('#userPhone3').val();
			var phoneRegex = /^\d{4}$/;
			var userAddr1 = $('#userAddr1').val()
			var addrRegex = /^\d{3}-\d{3}$/
			
			if(pw == ""){
				alert("비밀번호를입력해주세요.")
				$('#userPw').focus();
				return false;
			}
			
			
			if(pw.length < 6 || pw.length > 12){
				 alert("비밀번호는 6자이상 12자 이하입니다.");
				 $('#userPw').focus();
                 return false;
			}
			
			if(userPwCheck == ""){
				alert("비밀번호 확인을 입력해주세요.");
				$('#userPwCheck').focus();
				return false;
			}
			
			
			if(userPwCheck != pw){
				alert("비밀번호가 일치하지 않습니다.");
				$('#userPwCheck').focus();
				return false;
			}
		
			
			if(userName == ""){
				alert("이름을 입력해주세요.");
				$('#userName').focus();
				return false;
			}
			
			if(userPhone2 == ""){
				alert("전화번호를 입력해주세요.");
				$('#userPhone2').focus();
				return false;
			}
			
			if(userPhone3 == ""){
				alert("전화번호를 입력해주세요.");
				$('#userPhone3').focus();
				return false;
			}
			
			
			if (userPhone2.length !== 4) {
			    alert("전화번호를 네 자리씩 입력해주세요.");
			    $('#userPhone2').focus();
			    return false;
			}
		
			if (userPhone3.length !== 4) {
				$('#userPhone3').focus();
			    alert("전화번호를 네 자리씩 입력해주세요.");
			    return false;
			}
		
		
			// 이 부분이 필요 없을 것같음 구현후에 삭제 검증
// 			if (!addrRegex.test(userAddr1)) {
// 				alert("올바른 우편번호 형식은 xxx-xxx 형태입니다.");
// 				return false;
// 			}
			
			if(userAddr1 != ""){
				if(userAddr1.length !== 7){
					alert("우편번호는 여섯자리 입력해주세요.");
					$('#userAddr1').focus();
					return false;
				} 
			};
			
			
// 			console.log('emptyRequired : ', emptyRequired);
			
			if (emptyRequired.length > 0) {
                   // 비어있는 요소들의 data-label 값을 가져와서
                   var emptyLabels = new Set(); // 전화번호를 Set 객체를 사용하여 중복 제거
                   emptyRequired.each(function() {
                       emptyLabels.add($(this).attr("data-label"));
                   });

                   alert("다음 필수 입력 값을 입력해주세요: " + Array.from(emptyLabels).join(", "));
                   return false; //  Set 객체를 배열로 변환하고, 이를 문자열로 결합 후 폼 제출을 거부 
               }

			// 중복체크 안하고 무작정 join 누르는 유저들 때문에 추가
			$.ajax({
				 url: '/user/checkUserId.do',
			        type: 'POST',
			        data: {userId: userId},
			        success: function(data){
			        	if(data > 0){
			                alert("이미 사용중인 아이디입니다.");
			            } else {
							$.ajax({
							    url : "/user/signUpAction.do",
							    type: "POST",
							    dataType: "json",
							    data : param,
							    success: function(data, textStatus, jqXHR)
							    {
									alert("회원가입 완료");
// 									alert("메시지 : " + data.success);
									
				 					location.href = "/user/loginForm.do";
							    },
							    error: function (jqXHR, textStatus, errorThrown)
							    {
							    	alert("실패");
							    }
							});
			            }
			        },
			        error: function(e){
			            alert("error");
			        }
				});
			return false;
		});
		
		$("#checkUserId").on("click", function(){
			
			var userId = $('#userId').val();
			
			if(userId == ""){
				alert("아이디를 입력해주세요.")
				return false;
			}
			
			$.ajax({
				url: '/user/checkUserId.do',
				type: 'POST',
				data: {userId: userId},
				success: function(data){
					//기존 아이디가 존재한다면
					if(data > 0){
						alert("이미 사용중인 아이디입니다.")
					//기존 아이디가 존재하지 않으면
					}else{
						alert("사용가능한 아이디입니다.")
						userIdCheckedAgain = true;
						
					}	
				},
				error: function(e){
					alert("error");
				}
			});
			return false;
		});
		
		//검증 로직
		
		// 유저 아이디 입력시에 영어숫자제한 및 길이제한
		$('#userId').on('keyup', function(){
			this.value = this.value.replace(/[^0-9a-zA-Z]/g, '').substring(0,15);
			
		});
		
		if(!userIdCheckedAgain){
			$('#userId').on('change', function() {
	            alert("중복 확인을 해주세요.");
	            return false;
	        });
		};
		
		
		$('#userPw').on('keyup', function(){
			this.value = this.value.replace(/[^0-9a-zA-Z]/g, '').substring(0,12);
		});
		
		$('#userPwCheck').on('keyup', function(){
			this.value = this.value.replace(/[^0-9a-zA-Z]/g, '').substring(0,12);
		}); 
		
		$('#userName').on('keyup', function(){
			this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,4);
		});
		
		$('#userPhone2').on('keyup', function(){
			this.value = this.value.replace(/[^0-9]/g, '').substring(0,4);
		});
		
		$('#userPhone3').on('keyup', function(){
			this.value = this.value.replace(/[^0-9]/g, '').substring(0,4);
		});
		
		$('#userAddr1').on('keyup', function() {
		    let value = this.value.replace(/[^0-9]/g, '').substring(0,6);
		    if (value.length > 3) {
		        value = value.slice(0, 3) + '-' + value.slice(3, 6);
		    }
		    this.value = value;
		});	
		
		$('#userAddr2').on('keyup', function() {
			this.value = this.value.substring(0,49);
		});
		
		$('#userCompany').on('keyup', function() {
			this.value = this.value.substring(0,19);
		});
		
	});


</script>
<body>

	<div id="tableContainer">
		<div style="margin:auto; width:600px; margin-bottom:5px">
			<a href="/board/boardList.do">list</a>
	    </div>
		<form id="signUp">
	
			<table align="center" style="border-spacing:10px; border-collapse:separate; border:1px solid black; width:40%">
			
				<tr>
					<td align="center"  style="border:1px solid black; width:20%">id</td>
					<td style="border:1px solid black">
					<input id="userId" name="userId" class="required" style="ime-mode:disabled" data-label="아이디" maxlegnth="15"></td>
					<td align="center" ><input id="checkUserId" type="submit" value="중복확인"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">pw</td>
					<td  style="border:1px solid black"><input id="userPw" name="userPw" class="required" type="password" data-label="비밀번호"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">pwCheck</td>
					<td style="border:1px solid black"><input id="userPwCheck" name="userPwCheck" type="password" class="required" data-label="비밀번호확인"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">name</td>
					<td style="border:1px solid black"><input id="userName" name="userName" class="required" data-label="이름"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">phone</td>
					<td style="border:1px solid black">
					<select id="userPhone1" name="userPhone1">
						<c:forEach items='${codeList}' var='code'>
							<option value="${code.codeId}">${code.codeName}</option>
						 </c:forEach>
					</select>
					- <input id="userPhone2" name="userPhone2" class="required" data-label="전화번호" style="width: 60px"> 
					- <input id="userPhone3" name="userPhone3" class="required" data-label="전화번호" style="width: 60px">
					</td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">postNo</td>
					<td style="border:1px solid black"><input id="userAddr1" name="userAddr1"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">address</td>
					<td style="border:1px solid black"><input id="userAddr2" name="userAddr2"></td>
				</tr>
				<tr>
					<td align="center" style="border:1px solid black; width:20%">company</td>
					<td style="border:1px solid black"><input id="userCompany" name="userCompany" data-label="회사"></td>
				</tr>
			
			</table>
		</form>
		<div style="text-align: right; width:1065px; margin-top:5px">
			<input id="join" type="button" value="join"/>
		</div>
	</div>	
	



</body>
</html>