<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Issued Books</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<div class="header">Issued Books</div>

<div class="container">

<table>
<tr>
<th>Issue ID</th>
<th>Book ID</th>
<th>Student</th>
<th>Issue Date</th>
<th>Return Date</th>
<th>Status</th>
</tr>

<%
try {

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM issued_books");

    java.util.Date today = new java.util.Date();

    while(rs.next()) {

        int issueId = rs.getInt("issue_id");
        int bookId = rs.getInt("book_id");
        String student = rs.getString("student_name");
        String issueDate = rs.getString("issue_date");
        java.sql.Date returnDate = rs.getDate("return_date");

        String status;

        if(returnDate != null && today.after(returnDate)) {
            status = "Overdue";
        } else {
            status = "On Time";
        }
%>

<tr>
<td><%= issueId %></td>
<td><%= bookId %></td>
<td><%= student %></td>
<td><%= issueDate %></td>
<td><%= returnDate %></td>
<td>
    <% if(status.equals("Overdue")) { %>
        <span style="color:red;"><%= status %></span>
    <% } else { %>
        <span style="color:green;"><%= status %></span>
    <% } %>
</td>
</tr>

<%
    }

} catch(Exception e) {
    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
}
%>

</table>

<a href="dashboard.jsp" class="btn">Go to Dashboard</a>

</div>

</body>
</html>