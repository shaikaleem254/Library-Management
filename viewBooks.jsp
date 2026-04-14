<%@ include file="db.jsp" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<table border="1">
<tr>
<th>ID</th><th>Name</th><th>Author</th><th>Qty</th>
</tr>

<%
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM books");

while(rs.next()) {
%>
<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("author") %></td>
<td><%= rs.getInt("quantity") %></td>
</tr>
<%
}
%>


</table>
<a href="dashboard.jsp" class="btn">Go to Dashboard</a>