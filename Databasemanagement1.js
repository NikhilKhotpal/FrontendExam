/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * 
 */
 const questions = [
    {
        "question": "What is a primary key?",
        "answer": [
            {"text": "A unique identifier for a record", "correctAnswer": true},
            {"text": "A foreign key", "correctAnswer": false},
            {"text": "An index on a table", "correctAnswer": false},
            {"text": "A key that can have duplicate values", "correctAnswer": false}
        ]
    },
    {
        "question": "Which SQL statement is used to retrieve data?",
        "answer": [
            {"text": "SELECT", "correctAnswer": true},
            {"text": "GET", "correctAnswer": false},
            {"text": "SHOW", "correctAnswer": false},
            {"text": "FETCH", "correctAnswer": false}
        ]
    },
    {
        "question": "What does SQL stand for?",
        "answer": [
            {"text": "Structured Query Language", "correctAnswer": true},
            {"text": "Standard Query Language", "correctAnswer": false},
            {"text": "Sequential Query Language", "correctAnswer": false},
            {"text": "Simple Query Language", "correctAnswer": false}
        ]
    },
    {
        "question": "Which of the following is a DDL command?",
        "answer": [
            {"text": "SELECT", "correctAnswer": false},
            {"text": "INSERT", "correctAnswer": false},
            {"text": "CREATE", "correctAnswer": true},
            {"text": "UPDATE", "correctAnswer": false}
        ]
    },
    {
        "question": "What is a foreign key?",
        "answer": [
            {"text": "A key that links to a primary key in another table", "correctAnswer": true},
            {"text": "A unique key in the same table", "correctAnswer": false},
            {"text": "A key that is used for sorting", "correctAnswer": false},
            {"text": "A key that has no constraint", "correctAnswer": false}
        ]
    },
    {
        "question": "What is the purpose of the 'GROUP BY' clause?",
        "answer": [
            {"text": "To combine rows with similar values", "correctAnswer": true},
            {"text": "To filter records", "correctAnswer": false},
            {"text": "To sort records", "correctAnswer": false},
            {"text": "To join tables", "correctAnswer": false}
        ]
    },
    {
        "question": "Which function is used to count the number of rows in a SQL query?",
        "answer": [
            {"text": "SUM()", "correctAnswer": false},
            {"text": "COUNT()", "correctAnswer": true},
            {"text": "TOTAL()", "correctAnswer": false},
            {"text": "NUMBER()", "correctAnswer": false}
        ]
    },
    {
        "question": "What is a JOIN in SQL?",
        "answer": [
            {"text": "A command to create a new table", "correctAnswer": false},
            {"text": "A way to combine rows from two or more tables", "correctAnswer": true},
            {"text": "A way to delete records", "correctAnswer": false},
            {"text": "A way to update records", "correctAnswer": false}
        ]
    },
    {
        "question": "What does ACID stand for in database management?",
        "answer": [
            {"text": "Atomicity, Consistency, Isolation, Durability", "correctAnswer": true},
            {"text": "Aggregate, Consistency, Isolation, Durability", "correctAnswer": false},
            {"text": "Atomicity, Consistency, Integrity, Durability", "correctAnswer": false},
            {"text": "Atomicity, Concurrency, Isolation, Durability", "correctAnswer": false}
        ]
    },
    {
        "question": "Which SQL statement is used to update data in a database?",
        "answer": [
            {"text": "UPDATE", "correctAnswer": true},
            {"text": "MODIFY", "correctAnswer": false},
            {"text": "CHANGE", "correctAnswer": false},
            {"text": "ALTER", "correctAnswer": false}
        ]
    }
];

    

let currentQuestionIndex = 0;
let score = 0;
const totalTime = 60; // Time per question
let timeLeft = totalTime;
let videoStream;
let selectedAnswers = [];
let timer;

const questionElement = document.getElementById("question");
const answerButtonsElement = document.getElementById("answer-buttons");
const nextButton = document.getElementById("next-btn");
const timerElement = document.getElementById("timer");
const videoElement = document.getElementById("video");
const resultList = document.getElementById("result-list");

// WebRTC setup
const ws = new WebSocket('ws://localhost:3000');
const peerConnection = new RTCPeerConnection();

// Show camera video
function showVideo() {
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
            videoElement.srcObject = stream;
            videoStream = stream; // Store the video stream object

            // Add stream tracks to peer connection
            stream.getTracks().forEach(track => peerConnection.addTrack(track, stream));

            // Create and send an offer to the admin
            peerConnection.createOffer().then(offer => {
                return peerConnection.setLocalDescription(offer);
            }).then(() => {
                ws.send(JSON.stringify({
                    type: 'OFFER',
                    userId: 'user123',
                    data: peerConnection.localDescription
                }));
            }).catch(err => console.error('Error creating offer:', err));
        })
        .catch(err => console.error("Error accessing camera: ", err));
}

// Stop the camera video
function stopVideo() {
    if (videoStream) {
        videoStream.getTracks().forEach(track => track.stop()); // Stop the stream
        videoElement.srcObject = null; // Clear the video source
    }
}

// Start the quiz and camera handling
function startQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    timeLeft = totalTime;
    selectedAnswers = []; // Reset selected answers
    resultList.innerHTML = ""; // Clear previous results
    showQuestion();
    startTimer();
}

function showQuestion() {
    resetState();
    const currentQuestion = questions[currentQuestionIndex];
    questionElement.innerText = currentQuestionIndex + 1 + ". " + currentQuestion.question;

    currentQuestion.answer.forEach(answer => {
        const button = document.createElement("button");
        button.innerText = answer.text;
        button.classList.add("btn");
        button.dataset.correct = answer.correctAnswer; // Store if it's correct
        button.addEventListener("click", (e) => selectAnswer(e, answer));
        answerButtonsElement.appendChild(button);
    });

    // If we are in the last 10 questions, start the camera
    if (questions.length - currentQuestionIndex <= 10) {
        showVideo(); // Auto-start the camera on the last 10 questions
    }

    resetTimer(); // Reset the timer when a new question is shown
}

function resetState() {
    nextButton.disabled = true;
    answerButtonsElement.innerHTML = ""; // Clear answer buttons
}

function selectAnswer(e, answer) {
    const selectedBtn = e.target;
    const isCorrect = answer.correctAnswer;

    if (isCorrect) {
        selectedBtn.classList.add("correct");
        score++;
    } else {
        selectedBtn.classList.add("incorrect");
    }

    // Disable all buttons after selection
    Array.from(answerButtonsElement.children).forEach(button => button.disabled = true);

    // Store selected answer and its correctness
    selectedAnswers.push({
        question: questions[currentQuestionIndex].question,
        selected: answer.text,
        isCorrect: isCorrect
    });

    nextButton.disabled = false; // Enable next button
}

function handleNextButton() {
    currentQuestionIndex++;
    if (currentQuestionIndex < questions.length) {
        showQuestion();
    } else {
        clearInterval(timer); // Stop the timer when the quiz ends
        showResults();
        stopVideo(); // Auto-stop the camera after quiz ends
    }
}

nextButton.addEventListener("click", handleNextButton);

function startTimer() {
    timerElement.innerText = `Time: ${timeLeft}`;
    clearInterval(timer); // Clear any previous timers

    timer = setInterval(() => {
        timeLeft--;
        timerElement.innerText = `Time: ${timeLeft}`;
        if (timeLeft <= 0) {
            clearInterval(timer); // Stop the timer when it reaches 0
            handleNextButton(); // Automatically move to the next question
        }
    }, 1000);
}

function resetTimer() {
    clearInterval(timer); // Clear the previous timer
    timeLeft = totalTime; // Reset time for the next question
    startTimer(); // Start the timer again for the next question
}

function showResults() {
    resetState();
    questionElement.innerText = `Quiz Complete! Your Score: ${score} / ${questions.length}`;
    nextButton.innerText = "Play Again";
    nextButton.style.display = "block";
    document.getElementById("results").style.display = "block"; // Show results

    // Display selected answers with correctness
    selectedAnswers.forEach((answer, index) => {
        const li = document.createElement("li");
        li.innerText = `Q${index + 1}: ${answer.question} - Your answer: ${answer.selected} (${answer.isCorrect ? "Correct" : "Incorrect"})`;
        resultList.appendChild(li);
    });
}



window.onload = startQuiz;
    

