<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
int totalBooks = 0;
int issuedBooks = 0;

try {
    // Total Books
    Statement st1 = con.createStatement();
    ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) FROM books");

    if(rs1.next()) {
        totalBooks = rs1.getInt(1);
    }

    // Issued Books
    Statement st2 = con.createStatement();
    ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) FROM issued_books");

    if(rs2.next()) {
        issuedBooks = rs2.getInt(1);
    }

} catch(Exception e) {
    out.println("Error: " + e);
}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="./css/style.css">
</head>

<body>

<div class="header">Library Dashboard</div>

<div class="container">

<!-- Cards -->
<div class="card">Total Books: <%= totalBooks %></div>
<div class="card">Issued: <%= issuedBooks %></div>
<div class="card">Available: <%= totalBooks - issuedBooks %></div>

<br><br>

<!-- Navigation -->
<a href="addBook.jsp" class="btn">Add Book</a>
<a href="viewBooks.jsp" class="btn">View Books</a>
<a href="issueBook.jsp" class="btn">Issue Book</a>
<a href="returnBook.jsp" class="btn">Return Book</a>
<a href="viewIssued.jsp" class="btn">Issued Books</a>

<br><br>

<!-- Recent Issued Books -->
<h3>Recent Issued Books</h3>

<table>
<tr>
<th>Book ID</th>
<th>Student</th>
<th>Issue Date</th>
</tr>

<%
try {
    Statement st3 = con.createStatement();
    ResultSet rs3 = st3.executeQuery(
        "SELECT * FROM issued_books ORDER BY issue_id DESC LIMIT 5"
    );

    while(rs3.next()) {
%>
<tr>
<td><%= rs3.getInt("book_id") %></td>
<td><%= rs3.getString("student_name") %></td>
<td><%= rs3.getString("issue_date") %></td>
</tr>
<%
    }
} catch(Exception e) {
    out.println("Error loading data");
}
%>

</table>

</div>

</body>
</html>