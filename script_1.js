const questions = [
            {
                question: "What is the size of an int data type in Java?",
                answer :[{text: "1 Byte",correctAnswer:false},
                        {text: "2 Byte",correctAnswer: false},
                        {text: "4 Byte",correctAnswer : true},
                        {text: "3 Byte",correctAnswer : false},

                ] 
                
            },
            {
                question: "What is the default value of a boolean variable?",
                answer :[{text: "true",correctAnswer:false},
                        {text: "false",correctAnswer: true},
                        {text: "null",correctAnswer : false},
                        {text: "0",correctAnswer : false},
                      
                ] 
                
            },
            {
                question: "Which keyword is used to inherit a class in Java?",
                answer :[{text: "implements",correctAnswer:false},
                        {text: "extends",correctAnswer: true},
                        {text: "inherit",correctAnswer : false},
                        {text: "super",correctAnswer : false},
                      
                ] 
                
            },
            {
                question: "Which is a valid main method declaration?",
                answer :[{text: "public void main(String[] args)",correctAnswer:false},
                        {text: "public static void main(String[] args)",correctAnswer: true},
                        {text: "public static int main(String args)",correctAnswer : false},
                        {text: "public static void main()",correctAnswer : false},
                      
                ] 
                
            },
            {
                question: "Which is not a primitive data type in Java?",
                answer :[{text: "int",correctAnswer:false},
                        {text: "boolean",correctAnswer: false},
                        {text: "float",correctAnswer : false},
                        {text: "String",correctAnswer : true},
                      
                ] 
                
            },
            {
            question: "What does final keyword represent when applied to a variable?",
                answer :[{text: "int",correctAnswer:false},
                        {text: "Inheritable",correctAnswer: false},
                        {text: "Value cannot be changed",correctAnswer : true},
                        {text: "Abstract",correctAnswer : false},
                      
                ] 
                
            },
            {
            question: "What is the output of System.out.println(10 + 20 + Java);?",
                answer :[{text: "Java30",correctAnswer:false},
                        {text: "Java1020",correctAnswer: false},
                        {text: "30Java",correctAnswer : true},
                        {text: "1020Java",correctAnswer : false},
                      
                ] 
                
            },
            {
            question: "Which is a post-test loop?",
                answer :[{text: "do-while",correctAnswer:true},
                        {text: "for",correctAnswer: false},
                        {text: "while",correctAnswer : false},
                        {text: "foreach",correctAnswer : false},
                      
                ] 
                
            },
            {
            question: "What is the parent class of all classes in Java?",
                answer :[{text: "java.lang.String",correctAnswer: false},
                        {text: "java.util.List",correctAnswer: false},
                        {text: "java.lang.Object",correctAnswer : true},
                        {text: "java.io.Serializable",correctAnswer : false},
                      
                ] 
                
            },
            {
            question: "Which package contains the Scanner class?",
                answer :[{text: "java.io",correctAnswer:false},
                        {text: "java.util",correctAnswer: true},
                        {text: "java.lang",correctAnswer : false},
                        {text: "java.net",correctAnswer : false},
                      
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
const ws = new WebSocket('ws://localhost:8080');
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
    //nextButton.innerText = "Play Again";
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
