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
	String beginDate = request.getParameter("beginDate");
	String endDate = request.getParameter("endDate");
	String orderDate = request.getParameter("orderDate");
	System.out.println(orderDate +"<-orderDate");
	Class.forName("com.mysql.jdbc.Driver");
	
	String jdbcDriver = "jdbc:mysql://localhost:3306/jjdev?" +
			"useUnicode=true&characterEncoding=euckr";
	Connection conn =DriverManager.getConnection(jdbcDriver, "root", "java0000");
	if(beginDate == null & endDate == null){
		PreparedStatement pstmt = conn.prepareStatement("select * from orders;");
	}
	PreparedStatement pstmt = conn.prepareStatement("select amout from orders where order_date=?");
	pstmt.setString(1, orderDate);
	int amount = 0;
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		amount = rs.getInt("amout");
	}else{
		out.println("������ ���� ��¥�Դϴ�.");
	}
	//1.select amout from orders where order_date=?
	//2.1�� ����� 0�̸� ... ����!
	//3.1�� ����� 0���� ũ��
	if(amount ==0){
		out.println("����");
	}else{
		PreparedStatement pstmt2 = conn.prepareStatement("update orders set amout= amout-1 where order_date=?");
		pstmt2.setString(1, orderDate);
		pstmt2.executeUpdate();
		out.println("�ֹ�����");
	}
	//update orders set amout= amout-1 where order_date=?
%>
</body>
</html>