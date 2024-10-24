<%-- 
    Document   : ForgotPassword
    Created on : 25 Sep, 2024, 5:32:35 PM
    Author     : Nikhil
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>OTP Verification</h1>

        <!-- OTP Generation Section -->
        <div id="otp-section">
            <h2>Generate OTP</h2>
            <input type="email" id="email" placeholder="Enter your email" required>
            <button id="generate-otp">Generate OTP</button>
            <p id="otp-message"></p>
        </div>

        <!-- OTP Verification Section -->
        <div id="verify-section" style="display:none;">
            <h2>Verify OTP</h2>
            <input type="text" id="otp-code" placeholder="Enter the OTP" required>
            <button id="verify-otp">Verify OTP</button>
            <p id="verify-message"></p>
        </div>

        <!-- Change Password Section -->
        <div id="redirect-section" style="display:none;">
            <h2>Change Password</h2>
            <input type="password" id="new-password" placeholder="Enter new password" required>
            <button id="change-password">Change Password</button>
            <p id="change-password-message"></p>
        </div>
    </div>

    <script src="scriptss.js"></script>
</body>
</html>
