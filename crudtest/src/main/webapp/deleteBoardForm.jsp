<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
	<form action="<%=request.getContextPath()%>/deleteBoardAction.jsp">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<table border="1">
			<tr>
				<td>비밀번호를 입력하시오 : </td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">확인</button></td>
			</tr>
		</table>
	</form>

</body>
</html>