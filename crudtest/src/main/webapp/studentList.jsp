<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 

	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "SELECT student_no StudentNo, student_name studentName, student_gender studentGender, student_birth studentBirth, createdate, updatedate FROM student";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Student> list = new ArrayList<Student>();
	while(rs.next()) {
		Student s = new Student();
		s.studentNo = rs.getInt("studentNo");
		s.studentName = rs.getString("studentName");
		s.studentGender = rs.getString("studentGender");
		s.studentBirth = rs.getString("studentBirth");
		s.createdate = rs.getString("createdate");
	}
	// DB자원반납
		rs.close();
		stmt.close();
		conn.close();
%>
 <!--  View Layer -->
 	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li> 	
 	</ul>
 	
 	<h1>학생 리스트</h1>
 	<div>
 		<a href="<%=request.getContextPath()%>/addStudentForm.jsp">학생 추가</a>
 	</div>

 	<table border="1">
		<thead>
 		<tr>
 			<th>student_no</th>
 			<th>student_name</th>
 			<th>studentGender</th>
 			<th>studentBirth</th>
 			<th>createdate</th>
 			<th>updatedate</th>
 			<th>수정</th>
 			<th>삭제</th>
 			</tr>
 		</thead>
 		<tbody>
			<%
				for(Student s : list) {
		%>
			<tr>
				<td><%=s.studentNo%></td>
				<td><%=s.studentName%></td>
				<td><%=s.studentGender%></td>
				<td><%=s.studentBirth%></td>
				<td><%=s.createdate%></td>
				<td><%=s.createdate%></td>
				<td><%=s.updatedate%></td>
				<td><a href="<%=request.getContextPath()%>/updateStudentForm.jsp?studentNo<%=s.studentNo%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/deleteStudentAction.jsp?studentNo=<%=s.studentNo%>">삭제</a></td>
			</tr>
		<%
				}
		%>		
	
			
			</tbody>
 	</table>
 	
</body>
</html>