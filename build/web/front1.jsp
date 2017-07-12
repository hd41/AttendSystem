<%-- 
    Document   : front1
    Created on : Jul 3, 2017, 10:47:34 AM
    Author     : hd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.DateFormat, java.util.Calendar" %>

<!DOCTYPE html>
<html>
<head>
<title>Attendance Page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<style type="text/css">
	.top{
		background-color: rgb(208,150,150);
	}
	.matter{
		margin: auto;
		text-align: center;
		width: 80%;
		margin-left: 10%;
		padding-top: 5%;
		background-color: powderblue;
		padding-bottom:5%;
	}
	button{
		margin-top: 2%;
	}
        .nav{
		display: inline-block;
		width: 100%;
		background-color:rgb(208,180,150);
		padding-top: 1%;
		padding-bottom: 1%;
	}
	.footer{
		text-align: center;
		padding-top: 1%;
		padding-bottom: 1%;
		background-color: rgb(208,150,150);
	}
</style>

<body>
    <%
        String usr=(String)session.getAttribute("usr");
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();
        String currTime=dateFormat.format(date);
        
        %>
	<div class="fluid-container">
		<div class="top">
			<div class="row">
				<div class="col-xs-6">
					<h2 style="margin-left:10%;">Online Attendance System</h2>
				</div>
				<div class="col-xs-3" style="float:right;">
                                    <h3>Welcome!! <%= usr%></h3>
                                    <h4>Time: <%= currTime%></h4>
                                    <a href="signOut.jsp"><h6>Sign out</h6></a>
				</div>
			</div>
		</div>
                <div class="nav">
                    <a href="front1.jsp" style="font-size:18px; margin-left:10%; background-color:rgb(210,180,150);">Home</a> &nbsp; &nbsp;
                    <a href="front.jsp" style="font-size:18px; marign-left:20%; background-color:rgb(210,180,150);">Attendance History</a>
		</div>
		<div class="matter" style="text-align:center;">
			<div class="row">
			<a href="punchIn.jsp">
				<div class="col-md-6">
                                    <img src="${pageContext.servletContext.contextPath}/pIn1.JPG" style="width:250px; height:250px;"><br>
                                    <button class="btn btn-warning">Punch In</button>
				</div>
			</a>
			<a href="punchOut.jsp">
				<div class="col-md-6">
                                    <img src="${pageContext.servletContext.contextPath}/pOut1.JPG" style="width:250px; height:250px;"><br>
                                    <button class="btn btn-warning">Punch Out</button>
				</div>
			</a>
			</div>
		</div>
		<div class="footer">
			<h5>All Copyrights &copy; Reserved. Online Attendance System </h5>
		</div>
	</div>
</body>
</html>