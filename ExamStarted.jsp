<%-- 
    Document   : ExamStarted
    Created on : 14 Sep, 2024, 1:35:52 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="question-container">
        <h1 id="question">Loading question...</h1>
        <p>Time left: <span id="timer" name="LocalDateTime"></span> seconds</p>
        <form id="answers-form">
            <input type="checkbox" name="answer" id="answer1" value="answer1">
            <label for="answer1" id="label1">Loading...</label><br>
            <input type="checkbox" name="answer" id="answer2" value="answer2">
            <label for="answer2" id="label2">Loading...</label><br>
            <input type="checkbox" name="answer" id="answer3" value="answer3">
            <label for="answer3" id="label3">Loading...</label><br>
            <input type="checkbox" name="answer" id="answer4" value="answer4">
            <label for="answer4" id="label4">Loading...</label><br>
            <button type="button" id="next-button">Next</button>
        </form>
    </div>

    <script>
  let timer; // To store the interval so we can clear it
let currentQuestionId = 9; // Initialize currentQuestionId to start with the first question

// Function to start the countdown timer
function startTimer(timeLimit) {
    let timeLeft = timeLimit; // Set the initial time limit
    $('#timer').text(timeLeft);  // Update the timer with the initial time left

    // Clear any existing interval to avoid multiple timers
    clearInterval(timer);

    // Start a new interval to update the timer every second
    timer = setInterval(function() {
        timeLeft--; // Decrease the time by 1 second
        $('#timer').text(timeLeft);  // Update the countdown display with only the time left

        if (timeLeft <= 0) {
            clearInterval(timer); // Stop the timer when time runs out
            alert('Time is up!');
            $('#next-button').click(); // Automatically go to the next question when time is up
        }
    }, 1000); // 1000 ms = 1 second
}

// Function to load a question from the server
function loadQuestion(id) {
    if (id < 1 || id > 10) {
        alert('No more questions available');
        return;
    }
    clearInterval(timer); // Clear any previous timer
    $.ajax({
        url: `http://localhost:8098/questions/1${id}`, // Corrected URL
        method: 'GET',
        success: function(data) {
            $('#question').text(data.question);
            $('#answer1').val(data.answer1);
            $('#label1').text(data.answer1);
            $('#answer2').val(data.answer2);
            $('#label2').text(data.answer2);
            $('#answer3').val(data.answer3);
            $('#label3').text(data.answer3);
            $('#answer4').val(data.answer4);
            $('#label4').text(data.answer4);

            let timeLimit = data.timeLimit;

            // If timeLimit is not a valid number, default to 60 seconds
            if (isNaN(timeLimit) || timeLimit <= 0) {
                timeLimit = 60;
            }

            startTimer(timeLimit); // Start the countdown using the time limit from the backend
        },
        error: function() {
            alert('Error loading question');
        }
    });
}

// Initial load when the page is opened
$(document).ready(function() {
    loadQuestion(currentQuestionId); // Load the first question with currentQuestionId
});

$('#next-button').click(function() {
    const selectedAnswer = $('input[name="correctanswer"]:checked').val(); // Fixed the selector for the correct answer

   
    $.ajax({
        url: `http://localhost:8098/validate`, // Simplified URL
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ questionId: currentQuestionId, selectedAnswer: selectedAnswer }), // Use currentQuestionId instead of questionId
        success: function(response) {
            if (response.isCorrect) { // Assuming backend returns a JSON with isCorrect
                alert('Answer Will Submitted!');
            } else {
                alert('Answer Will Submitted');
            }
            currentQuestionId++; // Increment the question ID to move to the next question
            loadQuestion(currentQuestionId); // Load the next question
        },
        error: function() {
            alert('Error validating answer');
        }
    });
});

    </script>
</body>
</html>
