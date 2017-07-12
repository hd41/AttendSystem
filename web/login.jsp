<%-- 
    Document   : login
    Created on : Jun 27, 2017, 10:17:05 PM
    Author     : hd
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
    <%@page import="java.sql.*,java.util.*;" %>
        <%!
            Connection con;
            PreparedStatement ps;
            ResultSet rs;

            public static final String db_url = "jdbc:mysql://localhost:3306/attendance";
            public static final String jdbc = "com.mysql.jdbc.Driver";
            public static final String user = "root";
            public static final String db_pass = "tiger";
        %>
        <%
            String mail=(String)request.getParameter("usr");
            String pwd= (String)request.getParameter("pwd");
            try{
                    Class.forName(jdbc);
                    con = DriverManager.getConnection(db_url,user,db_pass);
                    Statement st = con.createStatement();
//                    st.executeUpdate(query);
                    String query="Select * from register where (mail='"+mail+"' OR phone='"+mail+"') and password='"+pwd+"';";
//                    PreparedStatement ps=con.prepareStatement("select * from register where mail=? and password=?");
//                    ps.setString(1, mail);  
//                    ps.setString(2, pwd);  
                    
                    ResultSet rs=st.executeQuery(query); 
                    Boolean status;
                    String usr="",reg="",create="";
                    if((status=rs.next())==true){
                        reg=rs.getString(1);
                        usr=rs.getString(2);
                        create=rs.getString(8);
                    }  
                    
                    String str[]=new String[2];
                    str=create.split(" ");
                    
                if(status==true)
                {
                    // passing regNo. and usrName
                    session.setAttribute("reg",reg);
                    session.setAttribute("usr",usr);
                    session.setAttribute("createDate",str[0]);
                    String site = new String("front1.jsp");
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", site);
                }else{
                        out.println("<h3>Entered Wrong LogIn Credentials!!</h3>");
                        %>
                <%@include file="index.html"%>
                        <%
//                        String site = new String("index.html");
//                        response.setStatus(response.SC_MOVED_TEMPORARILY);
//                        response.setHeader("Location", site);
                    }
                    con.close();
            }catch(Exception ex){
                out.println("OOPS!!, Error Encountered");
                ex.printStackTrace();
            }
        %>
    </body>
</html>