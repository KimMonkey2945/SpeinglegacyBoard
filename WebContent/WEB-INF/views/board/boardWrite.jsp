<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>

<script type="text/javascript">

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
  

    $(document).ready(function() {

        var boardNum = Number("${boardNum}") + 1;
        
        var formDataJson = $('#boardWrite').serializeObject(); //Json으로 먼저 바꾸기
        console.log('formDataJson', formDataJson);
        

        $("#submit").on("click", function() {

            var formDataJson = $('#boardWrite').serializeObject(); //Json으로 먼저 바꾸기
            var boardArray = [];
			// 반복해서 넣을 횟수 찾자,......
            var boardCount = Array.isArray(formDataJson['boardTitle']) ? formDataJson['boardTitle'].length : 1;
			
            console.log('formDataJson', formDataJson);
            
            for (var i = 0; i < boardCount; i++) {
                var board = {};
                for (var key in formDataJson) {
 						//hasOwnProperty에 대해 다시한번 공부하기
                    if (formDataJson.hasOwnProperty(key)) {
                        if (Array.isArray(formDataJson[key])) {
                            board[key] = formDataJson[key][i];
                        } else {
                            board[key] = formDataJson[key];
                        }
                    }
                }
                boardArray.push(board);
            }

            console.log("boardArray", boardArray);

            $.ajax({
                url: "/board/manyBoardWriteAction.do",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify(boardArray),
                success: function(data, textStatus, jqXHR) {
                    alert("작성완료");
                    alert("메세지:" + data.success);
                    location.href = "/board/boardList.do?pageNo=" + data.pageNo;
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert("실패");
                }
            });

        });

        $("#addRow").on("click", function() {

            var str = "";
            str +="<tr>"
            str +=	"<td width='120' align='center'>"
            str +=		"Type"
            str +=	"</td>"
            str +=	"<td width='400'>"
            str +=		"<select id='boardType' name='boardType'>"
            str +=			"<c:forEach items='${code}' var='code'>"
            str +=					'<option value="${code.codeId}">${code.codeName}</option>'
            str +=			"</c:forEach>"
            str +=		"</select>"
            str +=	"</td>"
            str +="</tr>"
            str += "<tr>"
            str += "<td width='120' align='center'>"
            str += "<input type='checkbox' id='checkBox' name='checkBox'/>"
            str += "Title"
            str += "</td>"
            str += "<td width='400'>"
            str += "<input name='boardTitle' type='text' size='50' value=''> "
            str += "</td>"
            str += "</tr>"
            str += "<tr>"
            str += "<td height='300' align='center'>"
            str += "Comment"
            str += "</td>"
            str += "<td valign='top'>"
            str += "<textarea name='boardComment' rows='20' cols='55'></textarea>"
            str += "</td>"
            str += "</tr>"
            str += "<input type='hidden' name='boardNum' value='" + boardNum++ + "'>";

            $("#addplace").append(str);

        });

        $("#deleteRow").on("click", function() {

            $("input[name=checkBox]:checked").each(function() {
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
				<td align="right"><input id="addRow" name="addRow"
					type="button" value="행추가"> <input id="deleteRow"
					name="deleteRow" type="button" value="행삭제"> 
					<input id="submit" name="submit" type="button" value="작성"></td>
			</tr>
			<tr>
				<td><input type='hidden' name='boardNum' value='${boardNum}'>
					<table id="mainTable" border="1">
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
								<!-- <input type="checkbox" id="mainCheckbox" name="mainCheckbox"/> -->
								Title
							</td>
							<td width="400"><input name="boardTitle" type="text"
								size="50" value="${board.boardTitle}">
							</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment" rows="20"
									cols="55">${board.boardComment}</textarea></td>
						</tr>
						<tbody id="addplace"></tbody>
						<tr>
							<td align="center">Writer</td>
							<td></td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a></td>
			</tr>
		</table>
	</form>
</body>
</html>