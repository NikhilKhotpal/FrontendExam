let currentQuestionIndex = 0;
let questions = [];
let userAnswers = [];
let score = 0;

// Fetch questions from the backend
function startQuiz() {
    $.ajax({
        url: 'http://localhost:8098/quiz/start',
        method: 'GET',
        success: function(response) {
            // Limit the questions to the first 10
            questions = response.slice(0, 10); // Get first 10 questions
            displayQuestion(currentQuestionIndex);
        },
        error: function(error) {
            console.error('Error fetching questions:', error);
        }
    });
}

// Display the current question and its answers
function displayQuestion(index) {
    if (index >= 0 && index < questions.length) {
        const question = questions[index];
        $('#question').text(question.question);
        $('#answer1').val(question.answer1);
        $('#label1').text(question.answer1);
        $('#answer2').val(question.answer2);
        $('#label2').text(question.answer2);
        $('#answer3').val(question.answer3);
        $('#label3').text(question.answer3);
        $('#answer4').val(question.answer4);
        $('#label4').text(question.answer4);
        $('input[name="answer"]').prop('checked', false);
    }
}

// Check if only one checkbox is selected
function isOneCheckboxSelected() {
    return $('input[name="answer"]:checked').length === 1;
}

// Get the selected answer
function getSelectedAnswer() {
    return $('input[name="answer"]:checked').val();
}

// Handle "Next" button click
$('#next-button').click(function() {
    if (isOneCheckboxSelected()) {
        const selectedAnswer = getSelectedAnswer();
        const correctanswer = questions[currentQuestionIndex].correctanswer; // Assuming the correct answer is available in the question object
 console.log('Selected Answer:', selectedAnswer); // Log selected answer
        console.log('Correct Answer:', correctanswer); // Log correct answer
        // Check if the selected answer is correct
        if (selectedAnswer === correctanswer) {
            score++; 
        }

        // Store user answer with correctness and the correct answer
        userAnswers.push({
            question: questions[currentQuestionIndex].question,
            selectedAnswer: selectedAnswer,
            isCorrect: (selectedAnswer === correctanswer), // Store if the answer was correct
            correctanswer: correctanswer // Store the correct answer
        });

        currentQuestionIndex++;
        if (currentQuestionIndex < questions.length) {
            displayQuestion(currentQuestionIndex);
        } else {
            submitAnswers();
        }
    } else {
        alert("Please select exactly one answer before proceeding.");
    }
});

// Submit answers to the backend
function submitAnswers() {
    console.log('Submitting answers:', userAnswers); // Log userAnswers before sending

    $.ajax({
        url: 'http://localhost:8098/quiz/results',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(userAnswers),
        success: function(response) {
            displayResults(response);
        },
        error: function(error) {
            console.error('Error submitting answers:', error);
        }
    });
}

// Display results
function displayResults(resultData) {
    console.log(resultData);
    $('#result').show();
    $('#result-container').empty(); // Clear previous results
    $('#result-container').show();
    $('#result-container').append(`<p>Total score: ${resultData.score} out of ${resultData.totalQuestions}</p>`); // Ensure resultData is valid
    resultData.selectedAnswers.forEach(function(answer, index) {
        $('#result-container').append(`<p>Question ${index + 1}: ${answer.question}</p>`);
        $('#result-container').append(`<p>Your answer: ${answer.selectedAnswer}</p>`);
        $('#result-container').append(`<p>Correct answer: ${answer.correctanswer}</p>`); // Display the correct answer
        $('#result-container').append(`<p>${answer.isCorrect ? 'Correct' : 'Incorrect'}</p>`);
        $('#result-container').append('<hr>');
    });
}

// Start the quiz when the page loads
startQuiz();
