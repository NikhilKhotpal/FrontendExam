<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style_1.css"> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>User Login</title>
    <style>
        @media (min-width: 992px) {
    .text-lg-start {
        text-align: left !important;
        display: flex;
    }
}
        .mt-auto{
            
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures the body takes the full height of the viewport */
            background-image: url('round-particle-lines-futuristic-gradient-wallpaper.jpg');
        }

        .login-container {
            background-color: lightblue;
            padding: 20px;
            border-radius: 20px;
            margin: 100px ; /* Centered and added margin to avoid overlap */
            width: 300px; /* Set a specific width for the login container */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* Optional: add shadow for better visibility */
            flex: 1; /* This will push the footer down */
                margin-top: 826px;
        }

        footer {
            background-color: #1c2331;
            color: white;
            padding: 20px 0;
            display: contents;
        }

        .footer-section {
            background-color: #6351ce; /* Adjust this for the footer's top section */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                <a class="navbar-brand" href="#"></a>
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="UserLogin.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="">Test</a>
                    </li>
                </ul>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="login-container">
        <h1>User Login</h1>
        <form action="" id="dologin">
            <div class="form-group">
                <label for="email" style="color: black">Email Id</label>
                <input type="email" name="email" id="email" placeholder="Enter Email" class="form-control">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" placeholder="Enter Password" class="form-control">
            </div>
            <button type="submit" name="action" class="btn btn-primary">Login</button>
            <div class="forgot-password">
                <a href="forgotpassword.html">Forgot your password?</a>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#dologin").submit(function(event) {
                event.preventDefault();

                // Validate form inputs
                if (!validateForm()) {
                    return; // Stop form submission if validation fails
                }

                ajaxPost();
            });

            function validateForm() {
                let isValid = true;
                let errorMsg = "";

                // Email validation
                const email = $("#email").val();
                const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailPattern.test(email)) {
                    errorMsg += "Please enter a valid email address.\n";
                    isValid = false;
                }

                // Password validation
                const password = $("#password").val();
                if (password.trim() === "") {
                    errorMsg += "Please enter a valid password.\n"; // Updated message
                    isValid = false;
                }

                // Display alert if validation fails
                if (!isValid) {
                    alert("Validation Error:\n" + errorMsg);
                }

                return isValid;
            }

            function ajaxPost() {
                var email = $("#email").val();
                var password = $("#password").val();

                var formData = {
                    email: email,
                    password: password,
                };

                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "http://localhost:8098/dologininto",
                    data: JSON.stringify(formData),
                    datatype: "application/text",
                    success: function(data, status) {
                        if (data == 'success') {
                            alert("Login Success");
                            location.assign("http://localhost:8080/FrontendExam/UserStartExam.jsp");
                        } else if (data == 'invalid_email') { // Changed condition
                            alert("Email is not available. Please register.");
                            location.assign("http://localhost:8080/FrontendExam/UserForm.jsp");
                        } else {
                            alert("Wrong credentials. Please check your email and password."); // Updated message
                        }
                    },
                    error: function(err) {
                        alert("An error occurred: " + err.responseText);
                    }
                });
            }
        });
    </script>

   <div class="container my-5">
  <!-- Footer -->
  <footer class="text-center text-white" style="background-color: #3f51b5">
    <!-- Grid container -->
    <div class="container">
      <!-- Section: Links -->
      <section class="mt-5">
        <!-- Grid row-->
        <div class="row text-center d-flex justify-content-center pt-5">
          <!-- Grid column -->
          <div class="col-md-2">
            <h6 class="text-uppercase font-weight-bold">
              <a href="#!" class="text-white">About us</a>
            </h6>
          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-2">
            <h6 class="text-uppercase font-weight-bold">
              <a href="#!" class="text-white">Products</a>
            </h6>
          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-2">
            <h6 class="text-uppercase font-weight-bold">
              <a href="#!" class="text-white">Awards</a>
            </h6>
          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-2">
            <h6 class="text-uppercase font-weight-bold">
              <a href="#!" class="text-white">Help</a>
            </h6>
          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-2">
            <h6 class="text-uppercase font-weight-bold">
              <a href="#!" class="text-white">Contact</a>
            </h6>
          </div>
          <!-- Grid column -->
        </div>
        <!-- Grid row-->
      </section>
      <!-- Section: Links -->



      <!-- Section: Text -->
      <section class="mb-1">
        <div class="row d-flex justify-content-center">
          <div class="col-lg-8">
            <p>
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Sunt
              distinctio earum repellat quaerat voluptatibus placeat nam,
              commodi optio pariatur est quia magnam eum harum corrupti
              dicta, aliquam sequi voluptate quas.
            </p>
          </div>
        </div>
      </section>
      <!-- Section: Text -->

     <!-- Section: Social -->
      <section class="text-center mb-5">
        <a href="" class="text-white me-4">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="" class="text-white me-4">
          <i class="fab fa-twitter"></i>
        </a>
        <a href="" class="text-white me-4">
          <i class="fab fa-google"></i>
        </a>
        <a href="" class="text-white me-4">
          <i class="fab fa-instagram"></i>
        </a>
        <a href="" class="text-white me-4">
          <i class="fab fa-linkedin"></i>
        </a>
        <a href="" class="text-white me-4">
          <i class="fab fa-github"></i>
        </a>
      </section>
      <!-- Section: Social -->
    </div>
    <!-- Grid container -->

    <!-- Copyright -->
    <div
         class="text-center p-3"
         style="background-color: rgba(0, 0, 0, 0.2)"
         >
      © 2024 Copyright:
      <a class="text-white" href=""
         ></a
        >
    </div>
    <!-- Copyright -->
  </footer>
  <!-- Footer -->
</div>
<!-- End of .container -->
<link
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
  rel="stylesheet"
/>
</body>
</html>
