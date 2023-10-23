<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";	
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT team_no teamNo, team_name teamName FROM team";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, teamNo);
	ResultSet rs = stmt.executeQuery();	
	ArrayList<Team> list = new ArrayList<Team>();
	while(rs.next()){
		Team t = new Team();
		t.teamNo = rs.getInt("teamNo");
		t.teamName = rs.getString("teamName");
		list.add(t);
	}
	rs.close();

	// 모델생성 + 자원반납 --> Model Layer 구현 END
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>학생입력</h1>
	<form action="<%=request.getContextPath()%>/addStudentAction.jsp">
		<table border ="1">
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="studentName">
				</td>
				<th>이름</th>
				<td>
					<input type="text" name="studentGender">
					<select>
					<option>남</option>
					<option>여</option>
					</select>
				</td>
			<tr>
				<th>생년월일<th>
				<td>
					<input type="date" name="studentBirth">
				</td>
			</tr>
				<!-- 팀 목록중 하나를 선택 - 팀 목록이 필요함. 쿼리에서 가져와야함. -->
				<select name="teamNo">
				<%
					for(Team t : list){
				%>		
						<option value="<%=t.teamNo%>"><%=t.teamName%></option>		
				<%
				}
				%>
				</select>		
		</table>
	</form>
</body>
</html>