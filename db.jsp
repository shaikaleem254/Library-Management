<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    String host   = "mysql-1891fa90-shaikalim254-d4ed.e.aivencloud.com";
    String port   = "28419";
    String dbName = "defaultdb";
    String user   = "avnadmin";
    String pass   = "AVNS_IXligRbZJLO_jWi5NYC";

    String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName
               + "?useSSL=true"
               + "&requireSSL=true"
               + "&verifyServerCertificate=false"
               + "&allowPublicKeyRetrieval=true"
               + "&serverTimezone=UTC";

    con = DriverManager.getConnection(url, user, pass);

} catch(Exception e) {
    out.println("<h3 style='color:red;'>DB Error: " + e.getMessage() + "</h3>");
    return;
}
%>
