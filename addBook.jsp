<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Add Book</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<div class="header">Add Book</div>

<div class="container">

<form method="post">

    <label>Book Name</label>
    <input type="text" name="name" required>

    <label>Author</label>
    <input type="text" name="author" required>

    <label>Quantity</label>
    <input type="number" name="qty" required>

    <input type="submit" value="Add Book" class="btn">

</form>

<br>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {

    try {

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO books(name, author, quantity) VALUES(?,?,?)"
        );

        ps.setString(1, request.getParameter("name"));
        ps.setString(2, request.getParameter("author"));
        ps.setInt(3, Integer.parseInt(request.getParameter("qty")));

        int i = ps.executeUpdate();

        if(i > 0) {
            out.println("<p class='success'>Book Added Successfully!</p>");
        } else {
            out.println("<p class='error'>Error adding book!</p>");
        }

    } catch(Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    }
}
%>
<a href="dashboard.jsp" class="btn">Go to Dashboard</a>

</div>

</body>
</html>