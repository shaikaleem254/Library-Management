<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Issue Book</title>

<!-- CSS -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<div class="header">Issue Book</div>

<div class="container">

<form method="post">

    <label>Book ID</label>
    <input type="text" name="book_id" required>

    <label>Student Name</label>
    <input type="text" name="name" required>

    <label>Student ID</label>
    <input type="text" name="sid" required>

    <label>Phone</label>
    <input type="text" name="phone" required>

    <label>Issue Date</label>
    <input type="date" name="issue" required>

    <label>Return Date</label>
    <input type="date" name="return" required>

    <input type="submit" value="Issue Book" class="btn">

</form>

<br>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {

    try {

        int bookId = Integer.parseInt(request.getParameter("book_id"));

        // 🔍 Check quantity first
        PreparedStatement check = con.prepareStatement(
            "SELECT quantity FROM books WHERE id=?"
        );
        check.setInt(1, bookId);
        ResultSet rs = check.executeQuery();

        if(rs.next()) {

            int qty = rs.getInt("quantity");

            if(qty > 0) {

                // ✅ Insert into issued_books
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO issued_books(book_id, student_name, student_id, student_phone, issue_date, return_date) VALUES (?,?,?,?,?,?)"
                );

                ps.setInt(1, bookId);
                ps.setString(2, request.getParameter("name"));
                ps.setString(3, request.getParameter("sid"));
                ps.setString(4, request.getParameter("phone"));
                ps.setString(5, request.getParameter("issue"));
                ps.setString(6, request.getParameter("return"));

                ps.executeUpdate();

                // 🔻 Reduce quantity
                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE books SET quantity = quantity - 1 WHERE id=?"
                );
                ps2.setInt(1, bookId);
                ps2.executeUpdate();

                out.println("<p class='success'>Book Issued Successfully!</p>");

            } else {
                out.println("<p class='error'>Book Out of Stock!</p>");
            }

        } else {
            out.println("<p class='error'>Invalid Book ID!</p>");
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