<%-- 
    Document   : signOut
    Created on : Jul 4, 2017, 5:58:07 PM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String usr="Himanshu";
            session.invalidate();
        %>
        <%@include file="index.html"%>
    </body>
</html>
