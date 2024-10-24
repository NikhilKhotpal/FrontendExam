<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Application</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
     <h1>Questions and Answers</h1>
    <h1 id="question">Loading question...</h1>

    <form id="answers-form">
        <p>A) <input type="checkbox" name="answer" id="answer1" value="answer1">
        <label for="answer1" id="label1">Loading...</label></p>
        
        <p>B) <input type="checkbox" name="answer" id="answer2" value="answer2">
        <label for="answer2" id="label2">Loading...</label></p>
        
        <p>C) <input type="checkbox" name="answer" id="answer3" value="answer3">
        <label for="answer3" id="label3">Loading...</label></p>
        
        <p>D) <input type="checkbox" name="answer" id="answer4" value="answer4">
        <label for="answer4" id="label4">Loading...</label></p>
        
        <button type="button" id="next-button">Next</button>
    </form>

    <h2 id="result" style="display: none;">Results:</h2>
    <div id="result-container" style="display: none;"></div>


    <script src="quiz.js"></script> <!-- Linking the JS script file -->
</body>
</html>
