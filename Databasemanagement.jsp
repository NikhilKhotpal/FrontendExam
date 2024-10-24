<%-- 
    Document   : Databasemanagement
    Created on : 24 Sep, 2024, 3:09:18 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .btn-cool-blues {
    background: #2193b0;  /* fallback for old browsers */
    background: -webkit-linear-gradient(to right, #6dd5ed, #2193b0);  /* Chrome 10-25, Safari 5.1-6 */
    background: linear-gradient(to right, #6dd5ed, #2193b0); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    color: #fff;
    border: 3px solid #eee;
}
        </style>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="" href="css/style_2.css">
    </head>
    <body>
        <div class="app" style="margin-right: 20px;">
<h1>Simple Quiz</h1>

<div class="quiz">
    
<h2 id="question">Question goes here</h2>

<div id="answer-buttons">
<button class="btn">Answer 1</button> <button class="btn">Answer 2</button>
<button class="btn">Answer 3</button>
<button class="btn">Answer 4</button>
</div>

<button id="next-btn">Next</button>
</div>
 <div class="col">
		    <button class="col btn btn-cool-blues" onclick="if (returnmsg('Do you want to go back to the dashboard?')) { window.location.href='UserStartExam.jsp'; }">Back To Dashboard</button>
		</div>
</div>
        <div id="results" style="display: none;">
                <h2>Results:</h2>
                <ul id="result-list"></ul>
            </div>
        <div id="timer-container">
        <div class="timer">
                    Time Left: <span id="timer">60</span> seconds
                </div>
        <video id="video" width="320" height="240" autoplay sty></video>
    </div>
        <div>
            
        </div>
        <a href="#">
        
    </a>
        <script>
            fetch('questions.json')
  .then(response => response.json())
  .then(data => {
    const questions = data.questions;
    startQuiz(questions);
  });

function startQuiz(questions) {
    // Now you can use the questions array to display the quiz
    console.log(questions);
}
function returnmsg(message) {
            return confirm(message);
        }
        </script>
        <script src="Databasemanagement1.js"></script>
    </body>
</html>
