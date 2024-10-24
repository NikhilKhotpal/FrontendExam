<%-- 
    Document   : QuestionAns
    Created on : 11 Sep, 2024, 12:22:20 PM
    Author     : Nikhil
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QA Form</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .more-answers { display: none; } /* Initially hide the additional answers */
    </style>
</head>
<body>
    <h1>Create QA</h1>
    <form id="qaForm">
        <label for="question">Question:</label><br>
        <input type="text" id="question" name="question" required><br><br>

        <label for="correctanswer">Correct Answer:</label><br>
        <input type="text" id="correctanswer" name="correctanswer" required><br><br>

        <label for="answer1">Alternative Answer 1:</label><br>
        <input type="text" id="answer1" name="answer1" required><br><br>

        <label for="answer2">Alternative Answer 2:</label><br>
        <input type="text" id="answer2" name="answer2" required><br><br>

        <label for="answer3">Alternative Answer 3:</label><br>
        <input type="text" id="answer3" name="answer3" required><br><br>

        <label for="answer4">Alternative Answer 4:</label><br>
        <input type="text" id="answer4" name="answer4" required><br><br>

        <button type="submit">Submit</button>
    </form>

    <h2>QA List</h2>
    <ul id="qaList"></ul>

    <script>
    $(document).ready(function() {
        // Function to handle form submission
        $('#qaForm').on('submit', function(e) {
            e.preventDefault();

            let qaData = {
                question: $('#question').val(),
                correctanswer: $('#correctanswer').val(),
                answer1: $('#answer1').val(),
                answer2: $('#answer2').val(),
                answer3: $('#answer3').val(),
                answer4: $('#answer4').val()
            };

            // Send AJAX POST request to add a new QA
            $.ajax({
                url: 'http://localhost:8098/add', // Your backend endpoint URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(qaData),
                success: function(response) {
                    alert('QA created successfully!');
                    loadQA(); // Reload the QA list after adding
                },
                error: function(error) {
                    console.log(error);
                    alert('Error creating QA');
                }
            });
        });

        // Function to load existing Q&A from the server and display correct answer
        function loadQA() {
            $.ajax({
                type: "GET",
                url: "http://localhost:8098/all", // Back-end API to fetch Q&A
                success: function(data) {
                    $("#qaList").empty(); // Clear the existing list
                    data.forEach(function(item) {
                        $("#qaList").append(
                            '<div id="qa-' + item.id + '">' +
                            '<h3>' + item.question + '</h3>' +
                            '<p><strong>Correct Answer:</strong> ' + item.correctanswer + '</p>' +
                            '<div class="more-answers">' +
                            '<p>Alternative 1: ' + item.answer1 + '</p>' +
                            '<p>Alternative 2: ' + item.answer2 + '</p>' +
                            '<p>Alternative 3: ' + item.answer3 + '</p>' +
                            '<p>Alternative 4: ' + item.answer4 + '</p>' +
                            '</div>' +
                            '<button class="show-more">Show More Answers</button>' +
                            '<button onclick="deleteQA(' + item.id + ')">Delete</button>' +
                            '</div>'
                        );
                    });

                    // Show more answers functionality
                    $('.show-more').on('click', function() {
                        $(this).prev('.more-answers').slideToggle(); // Toggle visibility of the answers
                        $(this).text($(this).text() === 'Show More Answers' ? 'Show Less Answers' : 'Show More Answers');
                    });
                },
                error: function(error) {
                    console.log(error);
                    alert("Error loading Q&A list");
                }
            });
        }

        // Function to delete a Q&A
        window.deleteQA = function(id) {
            if (confirm("Are you sure you want to delete this Q&A?")) {
                $.ajax({
                    type: "DELETE",
                    url: "http://localhost:8098/delete/" + id, // Back-end API to delete Q&A
                    success: function() {
                        alert("Q&A deleted successfully!");
                        $('#qa-' + id).remove(); // Remove the deleted element from the DOM
                    },
                    error: function(error) {
                        console.log(error);
                        alert("Error deleting Q&A");
                    }
                });
            }
        }

        // Initial load of QA list
        loadQA();
    });
    </script>
</body>
</html>
