<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>

<%@ include file="/ex03.html"%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table border=1 width=100%>
<tr>
	<td>티켓팅 날짜</td>
	<td>티켓남은 숫자</td>
	<td>티켓 예매하기>
</tr>
<%	
	request.setCharacterEncoding("EUC-KR");
	String beginDate = request.getParameter("beginDate");
	String endDate = request.getParameter("endDate");
	PreparedStatement pstmt = null;
	Class.forName("com.mysql.jdbc.Driver");
	
	String jdbcDriver = "jdbc:mysql://localhost:3306/jjdev?" +
			"useUnicode=true&characterEncoding=euckr";
	Connection conn =DriverManager.getConnection(jdbcDriver, "root", "java0000");
	if(beginDate == null & endDate == null){
		 pstmt = conn.prepareStatement("select * from orders;");
	}else if(beginDate == "" & endDate == ""){
		pstmt = conn.prepareStatement("SELECT * from orders;");
	}else if(beginDate != null & endDate == ""){
		pstmt = conn.prepareStatement("SELECT * from orders WHERE DATE_FORMAT(order_date,'%Y-%m-%d') BETWEEN ? AND '9999-12-30'");
		pstmt.setString(1, beginDate);
	}else if(beginDate == "" & endDate != null){
		pstmt = conn.prepareStatement("SELECT * from orders WHERE DATE_FORMAT(order_date,'%Y-%m-%d') BETWEEN '' AND ?");
		pstmt.setString(1, endDate);
	}else if(beginDate != null & endDate != null){
		pstmt = conn.prepareStatement("SELECT * from orders WHERE DATE_FORMAT(order_date,'%Y-%m-%d') BETWEEN ? AND ?");
	pstmt.setString(1, beginDate);
	pstmt.setString(2, endDate);
	}
	
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()){
	%>
	<tr>
		<td><%=rs.getString("order_date") %></td>
		<td><%=rs.getString("amout") %></td>
		<td><a href="<%=request.getContextPath() %>/orders_pro.jsp?send_date=<%=rs.getString("order_date")%>">예매하기</a>
		</td>
	</tr>
	<%
	}
	rs.close();
	pstmt.close();
	conn.close();

%>
</table>
</body>
</html>