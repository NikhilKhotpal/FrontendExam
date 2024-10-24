<%-- 
    Document   : JavaCheckbox
    Created on : 17 Sep, 2024, 2:15:55 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="" href="css/style_2.css">
    </head>
    <body>
      <div class="app">
            <h1>Simple Quiz</h1>
            <div class="quiz">
                <video id="video" width="320" height="240" autoplay ></video>

                <p id="exam-start-msg">The exam is starting. Please stay focused!</p>
                
                <h2 id="question">Question goes here</h2>
                
                <div id="answer-buttons">
                    <!-- Answer options will be dynamically generated here -->
                </div>
                
                <div class="timer">
                    Time Left: <span id="timer">60</span> seconds
                </div>
                
                <p id="warning-msg" style="color: red;"></p> <!-- Warning message area -->
                
                <button id="next-btn" disabled>Next</button>
            </div>
            
            <div id="results" style="display: none;">
                <h2>Results:</h2>
                <ul id="result-list"></ul>
            </div>
        </div>

        <script src="script_1.js"></script>
    </body>
</html>
