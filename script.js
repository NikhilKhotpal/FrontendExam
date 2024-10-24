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
const questionElement = document.getElementById("question");
const answerButtons = document.getElementById("answer-buttons");
const nextButton = document.getElementById("next-btn");
let currentQuestionIndex = 0;
let score = 0;

function startQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    nextButton.innerHTML = "Next";
    nextButton.style.display = "none"; // Hide the "Next" button initially
    showQuestion();
}

function showQuestion() {
    resetState();
    let currentQuestion = questions[currentQuestionIndex];
    let questionNo = currentQuestionIndex + 1;
    questionElement.innerHTML = questionNo + ". " + currentQuestion.question;

    currentQuestion.answer.forEach(answer => {
        const button = document.createElement("button");
        button.innerHTML = answer.text;
        button.classList.add("btn");
        answerButtons.appendChild(button);
        if (answer.correctAnswer) {
            button.dataset.correct = answer.correctAnswer;
        }
        button.addEventListener("click", selectAnswer);
    });
}

function resetState() {
    nextButton.style.display = "none"; // Hide the "Next" button initially
    while (answerButtons.firstChild) {
        answerButtons.removeChild(answerButtons.firstChild); // Clear previous answers
    }
}

function selectAnswer(e) {
    const selectedBtn = e.target;
    const isCorrect = selectedBtn.dataset.correct === "true";

    if (isCorrect) {
        selectedBtn.classList.add("correct");
        score++;
    } else {
        selectedBtn.classList.add("incorrect");
    }

    Array.from(answerButtons.children).forEach(button => {
        if (button.dataset.correct === "true") {
            button.classList.add("correct");
        }
        button.disabled = true; // Disable all buttons after an answer is selected
    });

    // Hide the answer buttons and show the "Next" button
    nextButton.style.display = "block"; // Show the "Next" button
}

function handleNextButton() {
    currentQuestionIndex++;
    if (currentQuestionIndex < questions.length) {
        showQuestion();
    } else {
        showScore();
    }
}

function showScore() {
    resetState();
    questionElement.innerHTML = `Quiz Complete! Your Score: ${score} / ${questions.length}`;
    nextButton.innerHTML = "Play Again";
    nextButton.style.display = "block";
}

nextButton.addEventListener("click", () => {
    if (currentQuestionIndex < questions.length) {
        handleNextButton();
    } else {
        startQuiz();
    }
});

// Start the quiz when the page loads
window.onload = startQuiz;