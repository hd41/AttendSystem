<%-- 
    Document   : register
    Created on : Jun 27, 2017, 10:30:55 PM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.DateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
            String fname=request.getParameter("fname");
            String lname=request.getParameter("lname");
            String ph=request.getParameter("phone");
            String mail=request.getParameter("mail");
            String pwd=request.getParameter("pass");
            String gender=request.getParameter("gender");
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String time1=dateFormat.format(date); 
            
            try{
                    Class.forName(jdbc);
                    con = DriverManager.getConnection(db_url,user,db_pass);
//                    Statement st = con.createStatement();
//                    st.executeUpdate(query);
                    PreparedStatement ps=con.prepareStatement("insert into register(fname,lname,phone,mail,password,gender,Time)"
                            + " values(?,?,?,?,?,?,?)");
                    ps.setString(1, fname);  
                    ps.setString(2, lname);  
                    ps.setString(3, ph);
                    ps.setString(4, mail);
                    ps.setString(5, pwd);
                    ps.setString(6, gender);
                    ps.setString(7, time1);
                    int status=ps.executeUpdate(); 
            
            //User obj=new User(fname,lname,ph,mail,pwd,gender);
            System.out.print("Initiated!!");
            if(status!=0)
            {
                session.setAttribute("mail", mail);
                session.setAttribute("usr",fname);
                String site = new String("success.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
            con.close(); 
        %>
        <jsp:forward page="success.jsp"/>
        <%
            }catch(Exception ex){
                out.println("OOPS!!, Error Encountered");
                ex.printStackTrace();
            }
        %>
    </body>
</html>
