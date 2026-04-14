<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<style>
/* Center login box */
.login-box {
    width: 350px;
    margin: 100px auto;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

.login-title {
    text-align: center;
    font-size: 22px;
    margin-bottom: 20px;
    color: #2c3e50;
}

.login-box input {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.login-btn {
    width: 100%;
    padding: 10px;
    background: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.login-btn:hover {
    background: #2980b9;
}

.error {
    color: red;
    text-align: center;
}
</style>

</head>

<body>

<div class="login-box">

<div class="login-title">Library Login</div>

<form method="post">

    <label>Username</label>
    <input type="text" name="u" required>

    <label>Password</label>
    <input type="password" name="p" required>

    <input type="submit" value="Login" class="login-btn">

</form>

<br>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {

    String u = request.getParameter("u");
    String p = request.getParameter("p");

    try {

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM admin WHERE username=? AND password=?"
        );

        ps.setString(1, u);
        ps.setString(2, p);

        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            response.sendRedirect("dashboard.jsp");
        } else {
            out.println("<p class='error'>Invalid Username or Password</p>");
        }

    } catch(Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    }
}
%>

</div>

</body>
</html>