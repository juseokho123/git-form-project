<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%	
	request.setCharacterEncoding("EUC-KR");
	String send_date = request.getParameter("send_date");
	System.out.println(send_date+ "<- send_date");
	PreparedStatement pstmt =null;
	Class.forName("com.mysql.jdbc.Driver");
	
	String jdbcDriver = "jdbc:mysql://localhost:3306/jjdev?" +
			"useUnicode=true&characterEncoding=euckr";
	Connection conn =DriverManager.getConnection(jdbcDriver, "root", "java0000");
	pstmt=conn.prepareStatement("select amout from orders where order_date=?");	
	pstmt.setString(1, send_date);
	System.out.println(pstmt);
	int amount = 0;
	ResultSet rs = pstmt.executeQuery();
	System.out.println(rs);
	if(rs.next()){
		amount = rs.getInt("amout");
	}
	if(amount ==0){
		out.println("����");
	}else{
		PreparedStatement pstmt2 = conn.prepareStatement("update orders set amout= amout-1 where order_date=?");
		pstmt2.setString(1, send_date);
		pstmt2.executeUpdate();
		out.println("�ֹ�����");
	}
	
	if(amount !=0){
	response.sendRedirect(request.getContextPath()+"/orders.jsp");
	}
	rs.close();
	pstmt.close();
	conn.close();
	//1.select amout from orders where order_date=?
	//2.1�� ����� 0�̸� ... ����!
	//3.1�� ����� 0���� ũ��
//
	//update orders set amout= amout-1 where order_date=?
%>
</body>
</html>