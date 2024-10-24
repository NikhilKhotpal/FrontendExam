<%-- 
    Document   : UserStartExam
    Created on : 11 Sep, 2024, 4:25:26 PM
    Author     : Nikhil
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">     
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <!-- Correct Font Awesome CDN -->

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Exam Dashboard</title>
    <style>
        .float-right {
            float: right;
            width: 30%;
            margin-right: 2rem;
            margin-top: 33px;
        }
        .card-dark-blue {
            background-color: #003366;
            color: white;
        }
      
        .my-5 {
    margin-top: 45rem !important;
    margin-bottom: 1rem !important;
        }
        body{
            display: table;
            margin-left: 102px;
        }
    </style>
  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

   <script>
    document.addEventListener('DOMContentLoaded', function () {
        function startExam(subject, questions, time, modalId, confirmButtonId, examPageUrl) {
            // Show the exam details in the modal
            document.getElementById(modalId).querySelector('#examSubject').innerText = subject;
            document.getElementById(modalId).querySelector('#examQuestions').innerText = questions;
            document.getElementById(modalId).querySelector('#examTime').innerText = time;

            // Show the modal
            var examModal = new bootstrap.Modal(document.getElementById(modalId));
            examModal.show();

            // Set up the "Start Exam" button
            document.getElementById(confirmButtonId).onclick = function () {
                navigator.mediaDevices.getUserMedia({ video: true })
                    .then(function (stream) {
                        var video = document.createElement('video');
                        video.srcObject = stream;
                        video.play();

                        // Send AJAX request to start exam
                        fetch("http://localhost:8098/startExam", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ subject: subject, startTime: new Date().toISOString() })
                        })
                            .then(response => response.json())
                            .then(data => {
                                alert("Exam started!");
                                window.location.href = examPageUrl;  // Navigate to the exam page
                            })
                            .catch(error => console.error('Error:', error));

                        examModal.hide();
                    })
                    .catch(function (err) {
                        console.error('Error accessing camera:', err);
                    });
            };
        }

        // Bind events to exam buttons
        document.getElementById('startDSA').addEventListener('click', function () {
            startExam('DSA', '10 Questions', '2 Hours', 'examModal', 'confirmStart', 'JavaQuestions.jsp');
        });

        document.getElementById('computernetwork').addEventListener('click', function () {
            startExam('Computer Network', '10 Questions', '10 Minutes', 'examModal1', 'confirmStart1', 'computerNetwork.jsp');
        });

        document.getElementById('Database').addEventListener('click', function () {
            startExam('Database Management', '10 Questions', '10 Minutes', 'examModal3', 'confirmStart3', 'Databasemanagement.jsp');
        });

        document.getElementById('Financial').addEventListener('click', function () {
            startExam('Financial Management', '10 Questions', '10 Minutes', 'examModal4', 'confirmStart4', 'FinancialManagementque.jsp');
        });
    });
</script>

</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Dropdown
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" aria-disabled="true">Disabled</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
    
    <!-- Java Exam Card 1) -->
    <div class="float-right">
        <div class="card card-dark-blue">
            <div class="card-body">
                <p class="mb-4">DSA</p>
                <p class="fs-30 mb-2">10 Questions</p>
                <p>2 Hours</p>
                <button class="btn btn-outline-primary" id="startDSA">Click To Start</button>
            </div>
        </div>
    </div>
    
    <!-- Modal for exam details -->
    <div class="modal fade" id="examModal" tabindex="-1" aria-labelledby="examModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="examModalLabel">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Subject:</strong> <span id="examSubject"></span></p>
                    <p><strong>Questions:</strong> <span id="examQuestions"></span></p>
                    <p><strong>Time:</strong> <span id="examTime"></span></p>
                    <p>Do you want to start the exam now?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <!-- Link to Java Questions -->
                    <a href="JavaQuestions.jsp"> 
                        <button type="submit" class="btn btn-primary" id="confirmStart">Start Exam</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- PHP Exam Card 2)-->
    <div class="float-right">
        <div class="card card-dark-blue">
            <div class="card-body">
                <p class="mb-4">Computer Network</p>
                <p class="fs-30 mb-2">10 Questions</p>
                <p>10 Minutes</p>
                <button class="btn btn-outline-primary" id="computernetwork">Click To Start</button>
            </div>
        </div>
    </div>
    
    <!-- Modal for PHP exam change exammodel1 -->
    <div class="modal fade" id="examModal1" tabindex="-1" aria-labelledby="examModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="examModalLabel">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Subject:</strong> <span id="examSubject">Computer Network</span></p>
                    <p><strong>Questions:</strong> <span id="examQuestions">10 Questions</span></p>
                    <p><strong>Time:</strong> <span id="examTime">10 Min</span></p>
                    <p>Do you want to start the exam now?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <!-- Link to Computer Network Questions -->
                    <a href="computerNetwork.jsp"> 
                        <button type="submit" class="btn btn-primary" id="confirmStart1">Start Exam</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
   
    
     <!--  Exam Card 3)-->
    <div class="float-right">
        <div class="card card-dark-blue">
            <div class="card-body">
                <p class="mb-4">Database Management</p>
                <p class="fs-30 mb-2">10 Questions</p>
                <p>10 Minutes</p>
                <button class="btn btn-outline-primary" id="Database">Click To Start</button>
            </div>
        </div>
    </div>
    
    <!-- Modal for PHP exam change exammodel1 -->
    <div class="modal fade" id="examModal3" tabindex="-1" aria-labelledby="examModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="examModalLabel">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Subject:</strong> <span id="examSubject">Database Management</span></p>
                    <p><strong>Questions:</strong> <span id="examQuestions">10 Questions</span></p>
                    <p><strong>Time:</strong> <span id="examTime">10 Min</span></p>
                    <p>Do you want to start the exam now?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <!-- Link to Computer Network Questions -->
                    <a href="Databasemanagement.jsp"> 
                        <button type="submit" class="btn btn-primary" id="confirmStart3">Start Exam</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    
     <!-- PHP Exam Card 4)-->
    <div class="float-right">
        <div class="card card-dark-blue">
            <div class="card-body">
                <p class="mb-4">Financial Management</p>
                <p class="fs-30 mb-2">10 Questions</p>
                <p>10 Minutes</p>
                <button class="btn btn-outline-primary" id="Financial">Click To Start</button>
            </div>
        </div>
    </div>
    
    <!-- Modal for PHP exam change exammodel1 -->
    <div class="modal fade" id="examModal4" tabindex="-1" aria-labelledby="examModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="examModalLabel">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Subject:</strong> <span id="examSubject">Financial Management</span></p>
                    <p><strong>Questions:</strong> <span id="examQuestions">10 Questions</span></p>
                    <p><strong>Time:</strong> <span id="examTime">10 Min</span></p>
                    <p>Do you want to start the exam now?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <!-- Link to Computer Network Questions -->
                    <a href="FinancialManagementque.jsp"> 
                        <button type="submit" class="btn btn-primary" id="confirmStart4">Start Exam</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
   
     <!-- PHP Exam Card 5)-->
    <div class="float-right">
        <div class="card card-dark-blue">
            <div class="card-body">
                <p class="mb-4">Computer Network</p>
                <p class="fs-30 mb-2">10 Questions</p>
                <p>10 Minutes</p>
                <button class="btn btn-outline-primary" id="">Click To Start</button>
            </div>
        </div>
    </div>
    
    <!-- Modal for PHP exam change exammodel1 -->
    <div class="modal fade" id="examModal2" tabindex="-1" aria-labelledby="examModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="examModalLabel">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Subject:</strong> <span id="examSubject">Computer Network</span></p>
                    <p><strong>Questions:</strong> <span id="examQuestions">10 Questions</span></p>
                    <p><strong>Time:</strong> <span id="examTime">10 Min</span></p>
                    <p>Do you want to start the exam now?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <!-- Link to Computer Network Questions -->
                    <a href=".jsp"> 
                        <button type="submit" class="btn btn-primary" id="confirmStart2">Start Exam</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Remove the container if you want to extend the Footer to full width. -->

  <!-- Footer -->
<!-- Footer -->
<footer class="col-12 col-lg- text-center text-white" style="background-color: #3f51b5">
    <div class="container my-5">
        <section class="mt-4">
            <div class="row text-center d-flex justify-content-center pt-5">
                <div class="col-6 col-sm-4 col-md-2">
                    <h6 class="text-uppercase font-weight-bold">
                        <a href="#!" class="text-white">About us</a>
                    </h6>
                </div>
                <div class="col-6 col-sm-4 col-md-2">
                    <h6 class="text-uppercase font-weight-bold">
                        <a href="#!" class="text-white">Products</a>
                    </h6>
                </div>
                <div class="col-6 col-sm-4 col-md-2">
                    <h6 class="text-uppercase font-weight-bold">
                        <a href="#!" class="text-white">Awards</a>
                    </h6>
                </div>
                <div class="col-6 col-sm-4 col-md-2">
                    <h6 class="text-uppercase font-weight-bold">
                        <a href="#!" class="text-white">Help</a>
                    </h6>
                </div>
                <div class="col-6 col-sm-4 col-md-2">
                    <h6 class="text-uppercase font-weight-bold">
                        <a href="#!" class="text-white">Contact</a>
                    </h6>
                </div>
            </div>
        </section>

        <section class="mb-1">
            <div class="row d-flex justify-content-center">
                <div class="col-lg-8">
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Sunt
                        distinctio earum repellat quaerat voluptatibus placeat nam,
                        commodi optio pariatur est quia magnam eum harum corrupti
                        dicta, aliquam sequi voluptate quas.
                    </p>
                </div>
            </div>
        </section>

        <section class="text-center mb-5">
            <a href="" class="text-white me-4">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="" class="text-white me-4">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="" class="text-white me-4">
                <i class="fab fa-google"></i>
            </a>
            <a href="" class="text-white me-4">
                <i class="fab fa-instagram"></i>
            </a>
            <a href="" class="text-white me-4">
                <i class="fab fa-linkedin"></i>
            </a>
            <a href="" class="text-white me-4">
                <i class="fab fa-github"></i>
            </a>
        </section>
    </div>

    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
        © 2024 Copyright: <a class="text-white" href=""></a>
    </div>
</footer>

  <!-- Footer -->

<!-- End of .container -->
<link
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
  rel="stylesheet"
/>
</body>
</html>
