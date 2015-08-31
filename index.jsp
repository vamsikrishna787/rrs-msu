<%@page import="java.text.DateFormat"%>
<%@page import="edu.msu.isa.jdbc.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="MSU -Voting System">
<meta name="author" content="Ganesh Talluri">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="assets/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="assets/css/bootstrap-theme.css"
	type="text/css" />
<link rel="stylesheet" href="assets/css/style.css" type="text/css" />
<link href="assets/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://s3.amazonaws.com/hayageek/libs/jquery/bootstrap.min.css"
	rel="stylesheet">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	(function() {
		var po = document.createElement('script');
		po.type = 'text/javascript';
		po.async = true;
		po.src = 'https://apis.google.com/js/client.js?onload=onLoadCallback';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(po, s);
	})();
</script>
<title>MSU - Voting System : Home</title>

<script type="text/javascript">
	function logout() {
		gapi.auth.signOut();
		location.reload();
	}
	function login() {
		var myParams = {
			'clientid' : '750012979736-c9bbh909aqg1ha2pni9ckl457sfn0u9d.apps.googleusercontent.com',
			'cookiepolicy' : 'single_host_origin',
			'callback' : 'loginCallback',
			'approvalprompt' : 'force',
			'scope' : 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.profile.emails.read'
		};
		gapi.auth.signIn(myParams);
	}

	function loginCallback(result) {
		if (result['status']['signed_in']) {
			var request = gapi.client.plus.people.get({
				'userId' : 'me'
			});
			request.execute(function(resp) {
				var email = '';
				if (resp['emails']) {
					for (i = 0; i < resp['emails'].length; i++) {
						if (resp['emails'][i]['type'] == 'account') {
							email = resp['emails'][i]['value'];
						}
					}
				}

				var str = "Name:" + resp['displayName'] + "<br>";
				str += "Image:" + resp['image']['url'] + "<br>";
				var img = resp['image']['url'].concat(0);
				str += "<img src='" + resp['image']['url'] + "' /><br>";

				str += "URL:" + resp['url'] + "<br>";
				str += "Email:" + email + "<br>";
				document.getElementById("profile").innerHTML = str;
				document.getElementById("clientEmail").innerHTML = email;

				window.location.assign('hello.jsp?Email=' + email + '&Image='
						+ img + '&Name=' + resp['displayName']);

			});

		}

	}
	function onLoadCallback() {
		//gapi.client.setApiKey('AIzaSyCcxiUVuHKsEAWjRsm8dMhqOHZINbVnjpY');
		gapi.client.load('plus', 'v1', function() {
		});

	}
</script>


</head>
<body>



	<%
		try {

			// Get Connection
			Connection connection = SQLServer.getSQLServerConnection();

			// Create statement
			Statement statement = connection.createStatement();

			String sql = "Select TOP 1 * FROM VMS_ElectionDates ORDER BY DateID DESC ";
			//Execute SQL statement returns a ResultSet object.
			ResultSet rs = statement.executeQuery(sql);
	%>





	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">MSU - Voting System</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><input class="btn btn-primary" type="button" value="Login"
						onclick="login()" />
						<div id="profile"></div>

						<div id="clientEmail" name="clienEmail"></div></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<p></p>
	<!-- Header Carousel -->
	<br>
	
	<header id="myCarousel" class=" row carousel slide">
		<!-- Wrapper for slides -->
		<div class="carousel-inner">
			<div class="item active">
				<div class="fill"
					style="background-image: url('http://sga.gsu.edu/files/2013/03/Getinvolved_elections_banner-01.jpg');"></div>
				<div class="carousel-caption">
					<h2>Right to Vote</h2>
				</div>
			</div>
			<div class="item">
				<div class="fill"
					style="background-image: url('http://www.murraystate.edu/downloads/webmanagement/identity/msu_logo_2009.jpg');"></div>
				<div class="carousel-caption">
					<h2>Murray State University</h2>
				</div>
			</div>
			<div class="item">
				<div class="fill"
					style="background-image: url('http://isa.iweb.bsu.edu/memb2013/Logo.jpg');"></div>
				<div class="carousel-caption">
					<h2>Indian Student Association</h2>
				</div>
			</div>
		</div>

		<!-- Controls -->
		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
			<span class="icon-prev"></span>
		</a> <a class="right carousel-control" href="#myCarousel"
			data-slide="next"> <span class="icon-next"></span>
		</a>
	</header>
	<%
		// Fetch on the ResultSet        
			// Move the cursor to the next record.

			while (rs.next()) {
				String NomStartDate = rs.getString(2);
				String NomEndDate = rs.getString(3);
				String VoteStartDate = rs.getString(4);
				String VoteEndDate = rs.getString(5);
				String ResultDate = rs.getString(6);

				DateStore dFormat = new DateStore();
				dFormat.setNomStartDate(NomStartDate);
				dFormat.setNomEndDate(NomEndDate);
				dFormat.setVoteStartDate(VoteStartDate);
				dFormat.setVoteEndDate(VoteEndDate);
				dFormat.setResultDate(ResultDate);

				session.setAttribute("df", dFormat);
	%>
	<!-- Page Content -->
	<div class="container">

		<!-- Marketing Icons Section -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="page-header">Important Dates to note</h3>
			</div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<i class="fa fa-fw fa-check"></i> Nomination
						</h4>
					</div>
					<div class="panel-body">
						<b>Start Date : </b><%=NomStartDate%>
						<br>
						<hr>
						<b>End Date : </b><%=NomEndDate%>

					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<i class="fa fa-fw fa-gift"></i> Voting
						</h4>
					</div>
					<div class="panel-body">
						<b>Start Date : </b><%=VoteStartDate%>
						<br>
						<hr>
						<b>End Date : </b><%=VoteEndDate%>

					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<i class="fa fa-fw fa-compass"></i> Results
						</h4>
					</div>
					<div class="panel-body">


						<b>Result Date : </b><%=ResultDate%>
						<br>
						<hr>
						<br />


					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
		<%
			}

				// Close connection.
				connection.close();

			}

			catch (Exception e) {
				e.printStackTrace(response.getWriter());
			}
		%>


		<%
			java.util.Date date = new java.util.Date();
		%>
		<p>
			<b>Current server time: <%=date.toString()%></b>
		</p>

		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>Copyright &copy; Murray State University 2015</p>
				</div>
			</div>
		</footer>

	</div>
	<!-- /.container -->

	<!-- jQuery -->
	<script src="assets/js/jquery.js"></script>
	<script src="assets/js/jqBootstrapValidation.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="assets/js/bootstrap.min.js"></script>

	<!-- Script to Activate the Carousel -->
	<script>
		$('.carousel').carousel({
			interval : 5000
		//changes the speed
		})
	</script>


</body>
</html>