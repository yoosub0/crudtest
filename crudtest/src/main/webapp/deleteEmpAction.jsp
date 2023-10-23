<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>

<%
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM emp WHERE emp_no=?";  // 변수명은 ?로 사용함. 
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, empNo);
	System.out.println(stmt +"<--stmt");
	
	int row = stmt.executeUpdate(); // 디버깅 코드
	if (row==1) {
		System.out.println("삭제성공");
	}  else {
		System.out.println("삭제실패");
	}
	stmt.close();
	conn.close();
	
	//리다이렉션 <-- 컨티롤러 레이어
	
	response.sendRedirect(request.getContextPath()+"/empList.jsp");


%>