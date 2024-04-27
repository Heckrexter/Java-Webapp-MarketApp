<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    .imgt {
        width: 100%;
        height: 300px;
        display: block;
        background-size: cover;
        background-position: center;
        transition: opacity 0.3s ease-in-out;
    }
    .imgt:hover {
        opacity: 0.5;
    }
    .thumbnail {
        padding: 0;
        border: none;
        background: none;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .elec {
        background-image: url("https://images.unsplash.com/photo-1550009158-9ebf69173e03?q=80&w=3301&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    }
    .cloth {
        background-image: url("https://images.unsplash.com/photo-1562157873-818bc0726f68?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGNsb3RoaW5nfGVufDB8fDB8fHwy");
    }
    .book {
        background-image: url("https://images.unsplash.com/photo-1513001900722-370f803f498d?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Ym9va3N8ZW58MHx8MHx8fDI%3D");
    }
    .furn {
        background-image: url("https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    }
    .maincontent {
        margin-top: 50px;
    }
</style>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">AmiShop</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="product.jsp">Product</a></li>
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
    <div class="maincontent">
        <div class="container-fluid catlist">
            <div class="row">
                <div class="col-md-3">
                    <div class="thumbnail">
                        <div class="imgt elec"></div>
                    </div>
                    <div class="caption">
                        <h1>Electronics</h1>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="thumbnail">
                        <div class="imgt cloth"></div>
                    </div>
                    <div class="caption">
                        <h1>Clothing</h1>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="thumbnail">
                        <div class="imgt book"></div>
                    </div>
                    <div class="caption">
                        <h1>Books</h1>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="thumbnail">
                        <div class="imgt furn"></div>
                    </div>
                    <div class="caption">
                        <h1>Furniture</h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid prodlist">
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                  <div class="carousel-item active"></div>
                  <!-- <div class="carousel-item"></div> -->
                  <!-- <div class="carousel-item"></div> -->
                </div>
                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</body>
</html>