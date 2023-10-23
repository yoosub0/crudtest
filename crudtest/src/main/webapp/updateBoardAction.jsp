<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import =  "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "UPDATE board SET board_title =?, board_content =?, board_writer =?, updatedate = NOW() where board_no=? AND board_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	stmt.setString(3, boardWriter);
	stmt.setInt(4, boardNo);
	stmt.setString(5, boardPw);
	
	
	int row = stmt.executeUpdate();
	
	stmt.close();
	conn.close();
	
	if(row ==1){
		response.sendRedirect(request.getContextPath()+"/boardOne.jsp");
	}	else {
		response.sendRedirect(request.getContextPath()+"/updateBoardForm.jsp?boardNo="+boardNo);
	}
	
%>
