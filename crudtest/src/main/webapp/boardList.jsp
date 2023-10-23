<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %> <!--  *를 이용함으로써 모든 java.sql를 import 가능. -->
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Board" %>
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
	
	int beginRow = 0;
	int rowPerPage = 10; // 한 페이지에 10개의 정보만 출력.
	/*
		SELECT board_no boardNo, board_title boardTitle, createdate 
		FROM board 
		ORDER BY createdate DESC 
		LIMIT ?,?					오라클과 달리 마지막에 LIMIT이라는 기능이 있음. ORDER BY를 먼저 수행 한 후 LIMIT를 하게 됨. 
	*/
	String sql = "SELECT board_no boardNo, board_title boardTitle, createdate FROM board ORDER BY createdate DESC LIMIT ?,?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, rowPerPage);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Board> list = new ArrayList<Board>();
	while(rs.next()) {
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.createdate = rs.getString("createdate");
		list.add(b);
	}
	// DB자원반납
	rs.close();
	stmt.close();
	conn.close();
	// Model Layer
%>
	<!-- View Layer -->
	<ul>
		<li><a href="<%=request.getContextPath()%>/home.jsp">홈으로</a></li>
		<li><a href="<%=request.getContextPath()%>/empList.jsp">직원관리</a></li>
		<li><a href="<%=request.getContextPath()%>/teamList.jsp">팀관리</a></li>
		<li><a href="<%=request.getContextPath()%>/studentList.jsp">학생관리</a></li>
		<li><a href="<%=request.getContextPath()%>/boardList.jsp">게시판관리</a></li>
	</ul>
	
	<h1>게시판</h1>
	<div>
		<a href="<%=request.getContextPath()%>/addBoardForm.jsp">글입력</a>
	</div>
	
	<table border="1">
		<tr>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		<%
			for(Board b : list) {
		%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/boardOne.jsp?boardNo=<%=b.boardNo%>">
							<%=b.boardTitle%>
						</a>
					</td>
					<td>
						<%=b.createdate%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>