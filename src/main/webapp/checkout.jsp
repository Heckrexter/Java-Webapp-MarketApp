<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
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
<style>
</style>
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
                    <li class="active">
                        <a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="false"></span> Cart <span class="badge" id="cartno"></span></a>
                    </li>
                <%} else {%>
                    <li><a href="login.jsp">Login/Register</a></li>
                <%}%>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Payment Details</h2>
        <form action="payment-success.jsp">
            <div class="form-group">
                <label for="cardName">Name on Card</label>
                <input type="text" class="form-control" id="cardName" placeholder="John Doe">
            </div>
            <div class="form-group">
                <label for="cardNumber">Card Number</label>
                <input type="text" class="form-control" id="cardNumber" placeholder="1111-2222-3333-4444">
            </div>
            <div class="form-group">
                <label for="expMonth">Expiry Month</label>
                <input type="text" class="form-control" id="expMonth" placeholder="MM">
            </div>
            <div class="form-group">
                <label for="expYear">Expiry Year</label>
                <input type="text" class="form-control" id="expYear" placeholder="YYYY">
            </div>
            <div class="form-group">
                <label for="cvv">CVV</label>
                <input type="password" class="form-control" id="cvv" placeholder="123">
            </div>
            <button type="submit" class="btn btn-primary">Submit Payment</button>
        </form>
    </div>
    
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</body>
</html>