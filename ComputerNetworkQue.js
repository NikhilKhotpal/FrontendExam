/**
 * 
 */
 const questions = [
            {
                question: "What is the primary function of a router in a network?",
                answer: [
                    {text: "To provide IP addresses to devices", correctAnswer: false},
                    {text: "To assign MAC addresses to devices", correctAnswer: false},
                    {text: "To manage data traffic within a single network", correctAnswer: false},
                    {text: "To connect multiple networks and route traffic between them", correctAnswer: true}
                ]
            },
            {
                question: "Which of the following protocols is used for secure communication over the internet?",
                answer: [
                    {text: "HTTP", correctAnswer: false},
                    {text: "FTP", correctAnswer: false},
                    {text: "HTTPS", correctAnswer: true},
                    {text: "SMTP", correctAnswer: false}
                ]
            },
            {
                question: "In which layer of the OSI model does a switch primarily operate?",
                answer: [
                    {text: "Physical Layer", correctAnswer: false},
                    {text: "Data Link Layer", correctAnswer: true},
                    {text: "Network Layer", correctAnswer: false},
                    {text: "Transport Layer", correctAnswer: false}
                ]
            },
            {
                question: "What is the default subnet mask for a Class C IP address?",
                answer: [
                    {text: "255.0.0.0", correctAnswer: false},
                    {text: "255.255.0.0", correctAnswer: false},
                    {text: "255.255.255.0", correctAnswer: true},
                    {text: "255.255.255.255", correctAnswer: false}
                ]
            },
            {
                question: "Which protocol is responsible for the reliable transmission of data in the TCP/IP model?",
                answer: [
                    {text: "UDP", correctAnswer: false},
                    {text: "ICMP", correctAnswer: false},
                    {text: "TCP", correctAnswer: true},
                    {text: "ARP", correctAnswer: false}
                ]
            },
            {
                question: "Which topology connects all devices in a network directly to a central hub?",
                answer: [
                    {text: "Star", correctAnswer: true},
                    {text: "Bus", correctAnswer: false},
                    {text: "Ring", correctAnswer: false},
                    {text: "Mesh", correctAnswer: false}
                ]
            },
            {
                question: "What does DNS stand for in computer networking?",
                answer: [
                    {text: "Domain Name System", correctAnswer: true},
                    {text: "Data Network Server", correctAnswer: false},
                    {text: "Distributed Network Service", correctAnswer: false},
                    {text: "Dynamic Node System", correctAnswer: false}
                ]
            },
            {
                question: "Which of the following is a private IP address?",
                answer: [
                    {text: "8.8.8.8", correctAnswer: false},
                    {text: "192.168.1.1", correctAnswer: true},
                    {text: "172.217.16.238", correctAnswer: false},
                    {text: "203.0.113.1", correctAnswer: false}
                ]
            },
            {
                question: "Which layer of the OSI model is responsible for data encryption?",
                answer: [
                    {text: "Physical Layer", correctAnswer: false},
                    {text: "Presentation Layer", correctAnswer: true},
                    {text: "Application Layer", correctAnswer: false},
                    {text: "Network Layer", correctAnswer: false}
                ]
            },
            {
                question: "Which protocol is used to resolve IP addresses to MAC addresses?",
                answer: [
                    {text: "DNS", correctAnswer: false},
                    {text: "ARP", correctAnswer: true},
                    {text: "DHCP", correctAnswer: false},
                    {text: "FTP", correctAnswer: false}
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
