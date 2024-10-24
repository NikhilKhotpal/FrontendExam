<%-- 
    Document   : resetpassword
    Created on : 25 Sep, 2024, 4:19:53 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="change-password-section">
        <label for="email">Email:</label>
        <input type="email" id="email" placeholder="Enter your email" required>
        <label for="old-password">Old Password:</label>
        <input type="password" id="old-password" placeholder="Enter old password" name="oldPassword" required>
        <label for="new-password">New Password:</label>
        <input type="password" id="new-password" placeholder="Enter new password" name="newPassword" required>
        <button id="change-password">Change Password</button>
        <p id="password-message"></p>
    </div>

    <script>
        $(document).ready(function () {
            $("#change-password").click(function () {
                const email = $("#email").val();
                const oldPassword = $("#old-password").val();
                const newPassword = $("#new-password").val();

                if (email && oldPassword && newPassword) {
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8098/change-password",
                        data: JSON.stringify({
                            email: email,
                            oldPassword: oldPassword,
                            newPassword: newPassword
                        }),
                        contentType: "application/json",
                        success: function(response) {
                            $("#password-message").text(response); // Show success message
                        },
                        error: function(xhr) {
                            $("#password-message").text(xhr.responseText); // Show error message
                        }
                    });
                } else {
                    $("#password-message").text("Please fill in all fields."); // Error message for empty fields
                }
            });
        });
    </script>
</body>
</html>
