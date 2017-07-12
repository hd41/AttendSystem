<%-- 
    Document   : atManipulation
    Created on : Jun 29, 2017, 9:48:08 AM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.DateFormat, java.util.Calendar" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
<title>Attendance Page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<script type="text/javascript">        
    function color1(){
        var row=document.getElementById("somerow");
        var col=row.getElementsByTagName("td");
        for(var i=0;i<8;i++){
                console.log(col[i].innerText);
            if(col[i].innerText==="A"){
                col[i].style.color="red";
            }else if(col[i].innerText==="H"){
                col[i].style.color="black";
            }else if(col[i].innerText==="P"){
                col[i].style.color="green";
            }else if(col[i].innerText==="MIS"){
                col[i].style.color="blue";
            }   
        }    
    }
</script>

<style type="text/css">
	.top{
		background-color: rgb(208,150,150);
	}
	.matter{
		margin-left: 15%;
		background-color: rgb(90,198,225);
		padding-top: 1%;
		padding-left: 2%;
		padding-right: 2%;
                padding-bottom: 2%;
		width: 70%;
		height: 80%;
		margin: 0 auto; 
	}
	table, th, td {
            border-collapse: collapse;
            text-align: center;
            border-spacing: 2%;
            padding: 2%;
	}
        .nav{
		display: inline-block;
		width: 100%;
		background-color:rgb(208,180,150);
		padding-top: 1%;
		padding-bottom: 1%;
	}
	.per{
		text-align: right;
		margin-top: 6%;
	}
	.footer{
		text-align: center;
		padding-top: 1%;
		padding-bottom: 1%;
		background-color: rgb(208,150,150);
	}
</style>
<%!
            Connection con;
            Statement stmt;
            ResultSet rs,rs1;

            public static final String db_url = "jdbc:mysql://localhost:3306/attendance";
            public static final String jdbc = "com.mysql.jdbc.Driver";
            public static final String user = "root";
            public static final String db_pass = "tiger";
%>

<%
    String usr=(String)session.getAttribute("usr");
    int reg=Integer.parseInt((String)session.getAttribute("reg"));
    String cDate=(String)session.getAttribute("createDate");
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
    Date date = new Date();
    String currTime=dateFormat.format(date); 
    String test1=request.getParameter("prev");
    String test2=request.getParameter("next");
    String time0="",time1="";
    System.out.println("test1: "+test1+" test2: "+test2);
    if(test1!=null && test1.equals("<")){
        time1=request.getParameter("pVal");
        Date date1=new SimpleDateFormat("yyyy/MM/dd").parse(time1);

        Calendar cal = Calendar.getInstance();
        cal.setTime(date1);    
        cal.add(Calendar.DATE, -6);  //change Calender.DATE to date1
        time0=dateFormat.format(cal.getTime());
    }
    else if(test2.equals(">")){
        time0=request.getParameter("nVal");
        Date date1=new SimpleDateFormat("yyyy/MM/dd").parse(time0);

        Calendar cal = Calendar.getInstance();
        cal.setTime(date1);    
        cal.add(Calendar.DATE, 6);
        time1=dateFormat.format(cal.getTime());
    }
    
    Calendar cal=Calendar.getInstance();
    Date date1=new SimpleDateFormat("yyyy/MM/dd").parse(time0);
    cal.setTime(date1);
    String []dates=new String[7];
    for(int i=0;i<7;i++){
        dates[i]=dateFormat.format(cal.getTime());
        cal.add(Calendar.DATE,1);
    }
    %>
    

<%
    String resp[]=new String [7];
    String diff[]=new String [7];
    long sum=0;
    int day=0;
    try{
                    Class.forName(jdbc);
                    con = DriverManager.getConnection(db_url,user,db_pass);
                    for(int i=0;i<7;i++){
                        //for chacking of the date if it is between the created account and the current date
                        Date date2=new SimpleDateFormat("yyyy/MM/dd").parse(dates[i]);
                        Date cTime=new SimpleDateFormat("yyyy/MM/dd").parse(currTime);
                        Date crDate=new SimpleDateFormat("yyyy/MM/dd").parse(cDate);
                        if(date2.after(crDate) && date2.before(cTime)){
                           String query1="Select * from holidays where date='"+dates[i]+"'";
                            stmt=con.createStatement();
                            rs1=stmt.executeQuery(query1);
                            Boolean status1=rs1.next();
                            
                            String query="Select * from span where RegNo="+reg+" and date='"+dates[i]+"'";
                            rs=stmt.executeQuery(query);
                            Boolean status=rs.next();
                            
                            System.out.println("status1: "+status1+" status: "+status);
                            //false means no record is found and ready to insert new record;
                            
                            String day1=new SimpleDateFormat("EE").format(date2);
                            if(day1.equals("Sat") || day1.equals("Sun")){
                                if(status==false){
                                    query="Insert into span(RegNo,date,signIn,signOut,day) values("+
                                        reg+",'"+dates[i]+"','H','H','"+day1+"')";
                                
                                    stmt.execute(query);
                                }                                
                                resp[i]="H";
                                diff[i]="--";
                            }else if(status1==true && status==false){
                                query="Insert into span(RegNo,date,signIn,signOut) values("+reg+",'"+dates[i]+"','H','H')";
                                stmt.execute(query);
                                resp[i]="H";
                                diff[i]="--";
                            }else{
                                if(status==false){
                                    query="Insert into span(RegNo,date,signIn,signOut) values("+reg+",'"+dates[i]+"','A','A')";
                                    stmt.execute(query);
                                    resp[i]="A";
                                    diff[i]="00";
                                    ++day;
                                }else if(status== true){
                                    String dur=rs.getString("duration");
                                    String sOut=rs.getString("signOut");
                                    if(sOut.equals("A")){
                                        resp[i]="A";
                                        diff[i]="00";
                                        ++day;
                                    }else if(sOut.equals("00:00:00") || sOut.equals("MIS")){
                                        query="update span set signOut='MIS' where RegNo="+reg+" AND date='"+dates[i]+"'";
                                        stmt.executeUpdate(query);
                                        resp[i]="MIS";
                                        diff[i]="00";
                                        ++day;
                                    }else if(sOut.equals("H")){
                                        resp[i]="H";
                                        diff[i]="--";
                                    }else{
                                        resp[i]="P";
                                        // code to take differnce between time
                                        if(!dur.equals("--")){
                                            long duration=Long.parseLong(dur);
                                            sum+=duration;
                                            int hours=(int)duration/3600;
                                            int remainder=(int)duration-hours*3600;
                                            int min=remainder/60;
                                            remainder=remainder-min*60;
                                            int secs=remainder;

                                            diff[i]=hours+":"+min+":"+secs;
                                        }else{
                                            diff[i]="--";
                                        }
                                        ++day;
                                    }
                                }
                            }
                        }else{
                            resp[i]="--";
                            diff[i]="--";
                        }
                    }
            }catch(Exception ex){
                ex.printStackTrace();
            }finally{
                con.close(); 
            }
    float acc=(float)(sum*100)/(day*8*60*60);
    
%>

<body onload="color1();">
	<div class="fluid-container">
		<div class="top">
			<div class="row">
				<div class="col-xs-6">
					<h2 style="margin-left:10%;">Online Attendance System</h2>
				</div>
				<div class="col-xs-3" style="float:right;">
                                    <h3>Welcome <%= usr%></h3>
                                    <h4>Time: <%= currTime%></h4>
                                    <a href="signOut.jsp"><h6>Sign out</h6></a>
				</div>
			</div>
		</div>
                <div class="nav">
                    <a href="front1.jsp" style="font-size:18px; margin-left:10%; background-color:rgb(210,180,150);">Home</a>&nbsp; &nbsp;
                    <a href="front.jsp" style="font-size:18px; marign-left:20%; background-color:rgb(210,180,150);">Attendance History</a>
		</div>
		<div class="matter">
			<h2>Hey! Fellas....</h2>
			<div class="attendance">
                            <form action="atManipulation.jsp" method="post">
				<table style="width:100%" cellpadding="4">
                                    <caption style="font-size: 24px; text-align:center;">Attendance from 
                                        <input type="text" name="pVal" value="<%= time0%> "> to 
                                        <input type="text" name="nVal" value="<%= time1%> ">
                                    </caption>
					<tr>
                                                <td><input type="submit" name="prev" value="<"></td>
						<td><b><%= dates[0]%></b></td>
						<td><b><%= dates[1]%></b></td>
						<td><b><%= dates[2]%></b></td>
						<td><b><%= dates[3]%></b></td>
						<td><b><%= dates[4]%></b></td>
						<td><b><%= dates[5]%></b></td>
						<td><b><%= dates[6]%></b></td>
                                                <td><input type="submit" name="next" value=">"></td>
					</tr>
					<tr id="somerow">
						<td>&nbsp;</td>
						<td><%= resp[0]%></td>
						<td><%= resp[1]%></td>
						<td><%= resp[2]%></td>
						<td><%= resp[3]%></td>
						<td><%= resp[4]%></td>
						<td><%= resp[5]%></td>
						<td><%= resp[6]%></td>
						<td>&nbsp;</td>
					</tr>	
                                        <tr >
                                            <td><b>Working Hours</b></td>
						<td ><%= diff[0]%></td>
						<td ><%= diff[1]%></td>
                                                <td ><%= diff[2]%></td>
                                                <td ><%= diff[3]%></td>
                                                <td ><%= diff[4]%></td>
						<td ><%= diff[5]%></td>
                                                <td ><%= diff[6]%></td>
                                            <td>&nbsp;</td>
					</tr>
				</table>
                            </form>
			</div>
			<div class="per">
				<h2>This Week's Accuracy: </h2><h1><%= acc%>% </h1>
			</div>
		</div>
		<div class="footer">
			<h5>All Copyrights &copy; Reserved. Online Attendance System </h5>
		</div>
	</div>
</body>
</html>
