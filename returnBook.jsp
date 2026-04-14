<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Return Book</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<div class="header">Return Book</div>

<div class="container">

<form method="post">

    <label>Enter Issue ID</label>
    <input type="text" name="id" required>

    <input type="submit" value="Return Book" class="btn">

</form>

<br>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {

    try {

        int id = Integer.parseInt(request.getParameter("id"));

        // Get book id
        PreparedStatement ps = con.prepareStatement(
            "SELECT book_id FROM issued_books WHERE issue_id=?"
        );
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if(rs.next()) {

            int bookId = rs.getInt("book_id");

            // Increase quantity
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE books SET quantity = quantity + 1 WHERE id=?"
            );
            ps2.setInt(1, bookId);
            ps2.executeUpdate();

            // Delete issue record
            PreparedStatement ps3 = con.prepareStatement(
                "DELETE FROM issued_books WHERE issue_id=?"
            );
            ps3.setInt(1, id);
            ps3.executeUpdate();

            out.println("<p class='success'>Book Returned Successfully!</p>");
            

        } else {
            out.println("<p class='error'>Invalid Issue ID!</p>");
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