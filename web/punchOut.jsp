<%-- 
    Document   : punchOut
    Created on : Jul 3, 2017, 12:38:32 PM
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
                    String pIn=rs.getString("signIn");
                    //false means no record is found and ready to insert new record;
                    if(status==true){
                        System.out.println("str0: "+str[0]+" str1: "+str[1]+ " Reg: "+rg);
                        DateFormat dateFormat1 = new SimpleDateFormat("HH:mm:ss");
                        Date d1=dateFormat1.parse(pIn);
                        Date d2=dateFormat1.parse(str[1]);
                        long diff=d2.getTime()-d1.getTime();
                        long diffSeconds=diff/1000;
                        query="Update span set signOut='"+str[1]+"',duration='"+diffSeconds+"' where RegNo="+rg+" AND date='"+str[0]+"'";
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
