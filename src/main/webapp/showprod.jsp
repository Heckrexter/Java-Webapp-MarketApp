<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter"%>
<%
String pname = "";
int pprice = 0;
String pcategory = "";
Connection con = null;
Statement stmt = null;
boolean prodfound = false;
String pidStr = request.getParameter("id");  // Use getParameter() to fetch query parameters
if (pidStr == null) {
    // response.sendRedirect("product.jsp");
    return; // Make sure to return after sending redirect
}
int pid = 0;
try {
    pid = Integer.parseInt(pidStr); // Convert string to integer
    pprice = pid;  // Assign to pprice for testing
} catch (NumberFormatException e) {
    // response.sendRedirect("product.jsp");  // Redirect if ID is not a valid integer
    return;
}
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopapp", "test", "test");
    stmt = con.createStatement();
    String query = "SELECT * FROM `products` WHERE Id = "+pid;
    pname = query;  // Assign to pname for testing
    ResultSet rs = stmt.executeQuery(query);
    if (rs.next()) {
        pname = rs.getString("Name");
        pprice = rs.getInt("Price");
        pcategory = rs.getString("Category");
        prodfound = true;
    }
    rs.close();
    
    prodfound = true;
} catch (Exception e) {
    e.printStackTrace();
    // response.sendRedirect("product.jsp");
} finally {
    try {
        if (stmt != null) {
            stmt.close();
        }
        if (con != null) {
            con.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>
<!-- get all products from the shopapp db, products table and display it all as -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap-theme.min.css" integrity="sha384-6pzBo3FDv/PJ8r2KRkGHifhEocL+1X2rVCTTkUfGk7/0pbek5mMa1upzvWbrUbOZ" crossorigin="anonymous">
</head>
<% Cookie c[] = request.getCookies();
boolean userfound = false;
String email = "";
if (c != null) {
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("username")) {
            email = c[i].getValue();
            userfound = true;%>
            <script>
            window.onload = function() {
                // Get the email value from a cookie or another source
                var email = '<%= email %>';  // Assume email is fetched correctly
            
                // Initialize a new FormData object
                var formData = new URLSearchParams();
                formData.append('email', email);
                
                // Make the fetch POST request
                fetch('<%=request.getContextPath()%>/userinfoapi', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log(data);
                    // Assuming 'data' is in the format: {'id':'X', 'count':'Y'}
                    if (data.count) {
                        document.getElementById('cartno').textContent = data.count;
                    } else {
                        console.error('No count returned, check data format and database results');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            }
            </script>
            <% break;
        }
    }
}%>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">AmiShop</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="homepage.jsp">Home</a></li>
                <li><a href="product.jsp">Products</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <!-- read cookies -->
                <% if(userfound == true){%>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= email %><span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Account</a></li>
                            <li><a href="#">Purchases</a></li>
                            <li><a href="#">Settings</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="#">Log Out</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="false"></span> Cart <span class="badge" id="cartno"></span></a>
                    </li>
                <%} else {%>
                    <li><a href="login.jsp">Login/Register</a></li>
                <%}%>
            </ul>
        </div>
    </nav>
    <% if (prodfound) {%>
        <div class="page-header">
            <h1><%= pname %><small> in <%= pcategory %></small></h1>
        </div>
        <div class="maincontent">
            <div class="container-fluid catlist">
                <div class="jumbotron">
                    <form action="/WebMarket/addtocart" method="post">
                        <h2>Rs. <%= pprice %></h1>
                        <input type="hidden" name="pid" value="<%= pid %>">
                        <h3>Quantity: <input name="quantity"></h3>
                        <button type="submit" class="btn btn-primary btn-lg">Add to Cart</button>
                        <p></p>
                    </form>
                </div>
            </div>
        </div>
    <%} else {%>
        <div class="page-header">
            <h1>Product not found</h1>
        </div>
    <%}%>
    
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</body>
</html>