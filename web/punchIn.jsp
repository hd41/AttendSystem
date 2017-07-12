<%-- 
    Document   : punchIn
    Created on : Jul 3, 2017, 12:04:12 PM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.DateFormat, java.util.Calendar" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            Connection con;
            Statement stmt;
            ResultSet rs;

            public static final String db_url = "jdbc:mysql://localhost:3306/attendance";
            public static final String jdbc = "com.mysql.jdbc.Driver";
            public static final String user = "root";
            public static final String db_pass = "tiger";
        %>
        <%
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String time1=dateFormat.format(date);
            String[] str=new String[2];
            str=time1.split(" ");
            
            String day=new SimpleDateFormat("EE").format(date);
            String reg=(String)session.getAttribute("reg");
            
            try{
                    Class.forName(jdbc);
                    con = DriverManager.getConnection(db_url,user,db_pass);
                    int rg=Integer.parseInt(reg);
                    String query="Select * from span where RegNo="+rg+" and date='"+str[0]+"'";
                    stmt=con.createStatement();
                    rs=stmt.executeQuery(query);
                    
                    int count=0;
                    Boolean status=rs.next();
                    //false means no record is found and ready to insert new record;
                    if(status==false){
                        query="Insert into span(RegNo,date,signIn,day) values("+reg+",'"+str[0]+"','"+str[1]+"','"+day+"')";
                        stmt.execute(query);
                    }else if(status==true && rs.getString("signIn").equals("A")){
                    
                        query="update span set signIn='"+str[1]+"',signOut='00:00:00' where RegNo="+reg+" AND date='"+str[0]+"'";
                        stmt.execute(query);
                    }
                        String site = new String("front1.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site);
            }catch(Exception ex){
                ex.printStackTrace();
            }finally{
                con.close(); 
            }

            %>
    </body>
</html>
