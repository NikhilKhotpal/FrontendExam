 $(document).ready(function () {
            $("#generate-otp").click(function () {
                const email = $("#email").val();
                if (email) {
                    $.post("http://localhost:8098/api/otp/generate", { email: email }, function (data) {
                        $("#otp-message").text("OTP sent to " + email);
                        $("#verify-section").show();
                        $("#otp-section").hide();
                    }).fail(function () {
                        $("#otp-message").text("Error sending OTP. Please try again.");
                    });
                } else {
                    $("#otp-message").text("Please enter a valid email.");
                }
            });

            $("#verify-otp").click(function () {
                const email = $("#email").val();
                const otpCode = $("#otp-code").val();
                if (otpCode) {
                    $.post("http://localhost:8098/api/otp/verify", { email: email, otpCode: otpCode }, function (data) {
                        if (data.success) {
                            $("#verify-message").text("OTP verified successfully!");
                            $("#change-password-section").show(); 
                            $("#verify-section").hide();
                        } else {
                            $("#verify-message").text("Invalid OTP or OTP expired.");
                        }
                    });
                

            $("#change-password").click(function () {
                const email = $("#email").val();
                const password = $("#password").val();
                if (password) {
                    $.post("http://localhost:8098/api/otp/change-password", { email: email, newPassword: password }, function (data) {
                        if (data) {
                            $("#password-message").text("Password changed successfully!");
                        } else {
                            $("#password-message").text("Error changing password. Please try again.");
                        }
                    }).fail(function () {
                        $("#password-message").text("Error changing password. Please try again.");
                    });
                } else {
                    $("#password-message").text("Please enter a new password.");
                }
            });
        });