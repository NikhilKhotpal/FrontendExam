<%-- 
    Document   : changepasswordserver
    Created on : 25 Sep, 2024, 4:32:43 PM
    Author     : Nikhil
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Change Result</title>
</head>
<body>
<%
    String email =(String) request.getParameter("email");
    String newPassword = request.getParameter("newpassword");

    String dbURL = "jdbc:mysql://localhost:3306/springboot_student";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        String sql = "UPDATE UserModel SET password = ? WHERE email = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, newPassword);
        pst.setString(2, email);
        
        int result = pst.executeUpdate();
        System.out.println("Rows affected: " + result); // Debugging output

        if (result > 0) {
            session.setAttribute("sescheck11", "Password successfully reset.");
            response.sendRedirect("UserLogin.jsp");
        } else {
            session.setAttribute("sescheck12", "Password reset failed. Please try again.");
            response.sendRedirect("changepassword.jsp");
        }
        
    } catch (SQLException ex) {
        session.setAttribute("sescheck12", "SQL error: " + ex.getMessage());
        response.sendRedirect("changepassword.jsp");
    
    }
%>
</body>
</html>
