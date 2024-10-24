/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
     const questions = [
    {
        question: "What is the primary goal of financial management?",
        answer: [
            { text: "Maximizing shareholder wealth", correctAnswer: true },
            { text: "Minimizing costs", correctAnswer: false },
            { text: "Maximizing sales", correctAnswer: false },
            { text: "Increasing market share", correctAnswer: false }
        ]
    },
    {
        question: "Which of the following is a component of the capital structure?",
        answer: [
            { text: "Long-term debt", correctAnswer: true },
            { text: "Short-term liabilities", correctAnswer: false },
            { text: "Accounts payable", correctAnswer: false },
            { text: "Inventory", correctAnswer: false }
        ]
    },
    {
        question: "What does the term 'liquidity' refer to?",
        answer: [
            { text: "The ability to meet short-term obligations", correctAnswer: true },
            { text: "The ability to increase sales", correctAnswer: false },
            { text: "The ability to maximize profits", correctAnswer: false },
            { text: "The ability to reduce costs", correctAnswer: false }
        ]
    },
    {
        question: "Which financial statement shows a company's assets, liabilities, and equity?",
        answer: [
            { text: "Income Statement", correctAnswer: false },
            { text: "Cash Flow Statement", correctAnswer: false },
            { text: "Balance Sheet", correctAnswer: true },
            { text: "Statement of Retained Earnings", correctAnswer: false }
        ]
    },
    {
        question: "What is the formula for calculating the net present value (NPV)?",
        answer: [
            { text: "NPV = Cash inflows - Cash outflows", correctAnswer: false },
            { text: "NPV = Sum of discounted cash flows - Initial investment", correctAnswer: true },
            { text: "NPV = Future value / (1 + r)^n", correctAnswer: false },
            { text: "NPV = Cash inflows + Cash outflows", correctAnswer: false }
        ]
    },
    {
        question: "What is 'working capital'?",
        answer: [
            { text: "Current assets minus current liabilities", correctAnswer: true },
            { text: "Total assets minus total liabilities", correctAnswer: false },
            { text: "Current assets plus current liabilities", correctAnswer: false },
            { text: "Total revenue minus total expenses", correctAnswer: false }
        ]
    },
    {
        question: "Which of the following is an example of a fixed cost?",
        answer: [
            { text: "Rent expense", correctAnswer: true },
            { text: "Raw materials", correctAnswer: false },
            { text: "Sales commissions", correctAnswer: false },
            { text: "Utilities", correctAnswer: false }
        ]
    },
    {
        question: "What does the price-to-earnings (P/E) ratio indicate?",
        answer: [
            { text: "The profitability of a company", correctAnswer: false },
            { text: "The valuation of a company's stock", correctAnswer: true },
            { text: "The company's revenue growth", correctAnswer: false },
            { text: "The company's debt levels", correctAnswer: false }
        ]
    },
    {
        question: "Which method is used to evaluate investment opportunities based on their cash flows?",
        answer: [
            { text: "Payback period", correctAnswer: false },
            { text: "Internal rate of return", correctAnswer: true },
            { text: "Break-even analysis", correctAnswer: false },
            { text: "Variance analysis", correctAnswer: false }
        ]
    },
    {
        question: "What is 'diversification' in investment management?",
        answer: [
            { text: "Investing in a variety of assets to reduce risk", correctAnswer: true },
            { text: "Investing all funds in a single asset", correctAnswer: false },
            { text: "Investing only in stocks", correctAnswer: false },
            { text: "Investing based on speculation", correctAnswer: false }
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



