<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	String teamName = request.getParameter("teamName");
	String teamCount = request.getParameter("teamCount");
	String teamBegin = request.getParameter("teamBegin");
	String teamEnd = request.getParameter("teamEnd");
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO team(team_name, team_count, team_begin, team_end, createdate, updatedate) VALUES(?,?,?,?,NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, teamName);
	stmt.setString(2, teamCount);
	stmt.setString(3, teamBegin);
	stmt.setString(4, teamEnd);
	
	System.out.println(stmt+" <--stmt");
	
	int row = stmt.executeUpdate();
	if (row==1) {
		System.out.println("입력성공");
	}  else {
		System.out.println("입력실패");
	}
	
	stmt.close();
	conn.close();
	
	
	// 리다이렉션
	response.sendRedirect(request.getContextPath()+"/teamList.jsp");
%>