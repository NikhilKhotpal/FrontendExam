<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Registration Form</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                background: lightblue;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            .Set {
                margin-bottom: 15px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
                color: #333;
            }
            input[type="text"], input[type="email"], input[type="password"], input[type="phone"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            input[type="radio"] {
                margin-right: 10px;
            }
            .Set input[type="radio"] {
                margin-right: 5px;
                margin-left: 10px;
            }
            button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #0056b3;
            }
            .Set input[type="radio"]:first-child {
                margin-left: 0;
            }
            .radio-label {
                margin-right: 15px;
            }
            @media (max-width: 600px) {
                .container {
                    padding: 15px;
                    color: #007bff;
                }
                button {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body style="background-image:url('130144.jpg'); ">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"  ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" ></script>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                <a class="navbar-brand" href="#"></a>
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="UserStartExam.jsp">Home</a>
                    </li>
                    
                               <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Dashboard</a>
                    </li>
                    
                    <!-- other nav items -->
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page"  href="UserLogin.jsp">LogOut</a>
                    </li>
                    
                             

                    
                </ul>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
        <div class="container">
            <h1>Register</h1>
            <form action="" id="RegForm">
                <div class="Set">
    <label for="name">Name</label>
    <input type="text" name="name" id="name" placeholder="Enter Name">
    <span id="nameError" style="color:red;"></span>
</div>
<div class="Set">
    <label for="email">Email Id</label>
    <input type="email" name="email" id="email" placeholder="Enter Email">
    <span id="emailError" style="color:red;"></span>
</div>
<div class="Set">
    <label for="password">Password</label>
    <input type="password" name="password" id="password" placeholder="Enter Password">
    <span id="passwordError" style="color:red;"></span>
</div>
<div class="Set">
    <label for="phone">Phone</label>
    <input type="phone" name="phone" id="phone" placeholder="Enter Phone Number">
    <span id="phoneError" style="color:red;"></span>
</div>
<div class="Set">
    <label>Department</label>
    <label class="radio-label"><input type="radio" name="department" value="IT"> IT</label>
    <label class="radio-label"><input type="radio" name="department" value="CSE"> CSE</label>
    <label class="radio-label"><input type="radio" name="department" value="BA" > BA</label>
    <span id="departmentError" style="color:red;"></span>
</div>

                <div class="Set">
                    <button type="submit" name="action">Submit</button>
                </div>
                   <label>Already Register<a href="UserLogin.jsp" >Click Here To Login</a></label>

            </form>
        </div>
        
        <!-- jQuery script to handle form submission -->
        
           <script>
$(document).ready(function() {
    $("#RegForm").submit(function(event) {
        event.preventDefault();

        // Validate form inputs
        if (!validateForm()) {
            return; // Stop form submission if validation fails 
        }

        ajaxPost();
    });

    function validateForm() {
    let isValid = true;

    // Clear previous error messages
    clearErrors();

    // Name validation
    const name = $("#name").val();
    const namePattern = /^[A-Za-z ]{6,14}$/; // Letters only, between 6 and 14 characters
    if (!namePattern.test(name)) {
        //alert("Name should have length between 6 to 14 characters and contain only letters.");
        $("#nameError").text("Name should have length between 6 to 14 characters and contain only letters.");
        isValid = false;
    }

    // Email validation
    const email = $("input[name='email']").val();
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test(email)) {
        //alert("Please enter a valid email address.");
        $("#emailError").text("Please enter a valid email address.");
        isValid = false;
    }

    // Password validation
    const password = $("input[name='password']").val();
    if (password.length < 6) {
        //alert("Password must be at least 6 characters long.");
        $("#passwordError").text("Password must be at least 6 characters long.");
        isValid = false;
    }

    // Phone number validation
    const phone = $("input[name='phone']").val();
    const phonePattern = /^\d{10}$/; // Adjust the regex if necessary
    if (!phonePattern.test(phone)) {
       // alert("Phone number must be 10 digits.");
        $("#phoneError").text("Phone number must be 10 digits.");
        isValid = false;
    }

    // Department validation
    const department = $("input[name='department']:checked").val();
    if (!department) {
       // alert("Please select a department.");
        $("#departmentError").text("Please select a department.");
        isValid = false;
    }

    return isValid;
}



    function clearErrors() {
        $("#nameError").text("");
        $("#emailError").text("");
        $("#passwordError").text("");
        $("#phoneError").text("");
        $("#departmentError").text("");
    }

    // Adding onblur event for validations
    $("#name").on("blur", validateForm);
    $("#email").on("blur", validateForm);
    $("#password").on("blur", validateForm);
    $("#phone").on("blur", validateForm);
    $("input[name='department']").on("change", validateForm);

    function ajaxPost() {
        var formData = {
            name: $("input[name='name']").val(),
            email: $("input[name='email']").val(),
            password: $("input[name='password']").val(),
            phone: $("input[name='phone']").val(),
            department: $("input[name='department']:checked").val()
        };

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "http://localhost:8098/Adduser",
            data: JSON.stringify(formData),
            dataType: "text",
            success: function(data) {
                if (data === "success") {
                    alert("Registered Successfully!");
                    location.assign("http://localhost:8080/FrontendExam/UserLogin.jsp");
                } else if (data === "User already registered") {
                    alert("User is already registered. Please login.");
                } else {
                    alert("Validation Error:\n" + data);  // Display validation errors from server
                }
            },
            error: function(err) {
                alert("An error occurred: " + err.responseText);
            }
        });
    }
});

</script>

        
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
