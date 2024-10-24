<%-- 
    Document   : ExamSheduledpage
    Created on : 10 Sep, 2024, 3:16:42 PM
    Author     : Nikhil
--%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .centre {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
                margin: 20px 0;
            }
            form {
                display: flex;
                flex-direction: column;
                width: 300px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            label, input, select {
                width: 100%;
                margin-bottom: 10px;
            }
            input, checkbox{
                width: auto;
                margin: 0 17px;
            }
            .checkbox-inp{
                display: flex;
            }
            input, select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            button {
                background-color: #cc2127;
                color: #fff;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background-color: #a51b1f;
            }
            h1 {
                text-align: center;
                color: #cc2127;
                background-color: #000000;
                padding: 10px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .left {
                display: flex;
                flex-direction: column;
                margin-top: 10px;
            }
            .left label {
                margin-bottom: 5px;
            }
            .left input {
                margin-right: 10px;
            }
            .checkbox-section {
                display: flex;
                flex-direction: column;
            }
            .sep {
                display: flex;
            }
            .hidden {
                display: none;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Exam Will Be Scheduled</h1>
        <form action="" id="shedule">
            
           
            <div class="centre" id="subject-container">
                <label>Subject</label>
                <select name="subject" id="basubject" class="hidden">
                    <option value="Data Science">Data Science</option>
                    <option value="Financial Management">Financial Management</option>
                    <option value="Data Visualization">Data Visualization</option>
                </select>
                <select name="subject" id="subject" class="hidden" >
                    <option>Select</option>
                    <option value="Computer Network">Computer Network</option>
                    <option value="Data Structure">Data Structure</option>
                    <option value="Database Management">Database Management</option>
                    <option value="Object Oriented Programming">Object Oriented Programming</option>
                </select>
            </div>
            <div class="centre">
                <label>Time</label>
                <input type="time" name="time" id="time">
            </div>
            <div class="centre">
                <label>Select Date</label>
                <input type="date" name="date" id="date">
            </div>
            <div class="checkbox-section">
                <label>Select Department</label>
                <label><input type="checkbox" name="department" id="it" value="IT"> IT</label>
                <label><input type="checkbox" name="department" id="cse" value="C.S"> CSE</label>
                <label><input type="checkbox" name="department" id="ba" value="BA"> BA</label>
            </div>
            <div class="centre">
                <button type="submit" name="action" class="btn btn-primary">Submit</button>
            </div>
        </form>
        
        <script>
            $(document).ready(function() {
                // Function to update visibility of subject dropdown
                function updateSubjectVisibility() {
                    var itChecked = $("#it").is(":checked");
                    var cseChecked = $("#cse").is(":checked");
                    var baChecked=$("#ba").is(":checked");
                    if (itChecked || cseChecked) {
                        $("#subject").removeClass("hidden");
                    } else {
                        $("#subject").addClass("hidden");
                    }
                    
                  if (baChecked) {
                        $("#basubject").removeClass("hidden");
                    } else {
                        $("#basubject").addClass("hidden");
                    }
                }

                // Initial check
                updateSubjectVisibility();

                // Event listener for checkboxes
                $("input[name='department']").change(function() {
                $("input[name='department']").not(this).prop('checked', false); // Uncheck other checkboxes
                
                    updateSubjectVisibility();
                });

                $("#shedule").submit(function(event) {
                    event.preventDefault();
                    ajaxPost();
                });

                function ajaxPost() {
                    var formData = {
                        
                        date: $("input[name='date']").val(),
                        time: $("input[name='time']").val(),
                        department: $("input[name='department']:checked").val(),
                    }
                    console.log(formData);

                    $.ajax({
                        type: "post",
                        contentType: "application/json",
                        url: "http://localhost:8098/savestudent",
                        data: JSON.stringify(formData),
                        datatype: "application/text",
                        success: function(data) {
                            if (data == "success") {
                                alert("!!! Thank You For Registering You Will Receive a Message !!!!");
                                location.assign("http://localhost:8080/FrontendExam/QuestionAns.jsp");
                            }
                            console.log(data);
                        }
                    });
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>

