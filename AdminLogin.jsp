<%-- 
    Document   : AdminLogin
    Created on : 12 Sep, 2024, 5:20:16 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .centre, div {
                text-align: center;
            }
        </style>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- jQuery CDN (required for using $) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
    </head>
    <body>
        <h1 style="text-align: center; background-color: #52C4FF; color: #F5F7FF;">Admin Login</h1>
        <nav class="navbar navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="">Dashboard</a>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </nav>
        <div class="centre">
            <label>Username</label>
            <input type="email" name="email" id="email">
        </div>
        <div class="centre">
            <label>Password</label>
            <input type="password" name="password" id="password">
        </div>
        <div class="centre">
            <button type="submit" id="dologin" name="action">Submit</button>
        </div>
        
        <script>
            $(document).ready(function() {
                // Handle form submission
                $('#dologin').on('click', function(event) {
                    event.preventDefault();
                    ajaxPost();
                });

                function ajaxPost() {
                    var email = $("#email").val();
                    var password = $("#password").val();

                    var formData = {
                        email: email,
                        password: password
                    };

                    console.log(formData);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        url: "http://localhost:8098/Adminlogin",
                        data: JSON.stringify(formData),
                        dataType: "text",
                        success: function(data, status) {
                            console.log(data);
                            if (data === 'success') {
                                alert("Login Success");
                                location.assign("http://localhost:8080/FrontendExam/Dashboard.jsp");
                            } else if (data === 'email') {
                                alert("Email is not available, please register.");
                                location.assign("http://localhost:8080/FrontendExam/index.jsp");
                            } else {
                                alert("Wrong credentials");
                            }
                        },
                        error: function(error) {
                            console.log(error);
                            alert("Error during login");
                        }
                    });
                }
            });
        </script>
    </body>
</html>
