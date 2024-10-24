<!DOCTYPE html>
<html>
    <head>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css"> 
        <script src="js/dashboard.js"></script>
        <script src="js/dashboard-dark.js"></script>
        <style>
            /* Add a custom class to float the card to the right */
            .float-right {
                float: right;
                width: 30%;
                margin-right: 2rem;
            }
            /* To make sure the main content flows properly with the sidebar */
            .container-fluid {
                display: flex;
                flex-direction: row;
                justify-content: flex-start;
            }
        </style>
    </head>
    <body>
        <h1 style="text-align: center;color: cornsilk;background-color: black;margin: 1rem;">Exam Schedule</h1>
        
        <!-- partial -->
        <div class="container-fluid page-body-wrapper">
            <!-- Sidebar -->
            <nav class="sidebar sidebar-offcanvas" id="sidebar">
                <ul class="nav">
                    <!-- Navigation links -->
                    <li class="nav-item"><a class="nav-link" href="Dashboard.jsp"><i class="icon-grid menu-icon"></i><span class="menu-title">Dashboard</span></a></li>
                    <!-- Other items omitted for brevity -->
                <li class="nav-item">
       <a class="nav-link" href="ExamScheduledpage.jsp" aria-expanded="false" aria-controls="ui-basic">
        
        <span class="menu-title">Exam Schedules</span>
        
      </a>          
     
          
    </li>
             
                </ul>
                
                
            </nav>
            
            <!-- Main content area -->
            <div class="main-content">
                <!-- Other main content can go here -->
            </div>

            <!-- Float the card to the right -->
            
            <div class="float-right">
                <div class="card card-dark-blue">
                    <div class="card-body">
                        <p class="mb-4">Maths</p>
                        <p class="fs-30 mb-2">1000</p>
                        <p>1 Hours Test</p>
                        <button class="btn btn-outline-primary">Click To Start</button>
                    </div>
                </div>
            </div>
                
               <div class="float-right">
                <div class="card card-dark-blue">
                    <div class="card-body">
                        <p class="mb-4">Science</p>
                        <p class="fs-30 mb-2">15 Question</p>
                        <p>10 Min</p>
                       <button class="btn btn-outline-primary">Click To Start</button>

                    </div>
                </div>
            </div>
               <div class="float-right">
                <div class="card card-dark-blue">
                    <div class="card-body">
                        <p class="mb-4">Java</p>
                        <p class="fs-30 mb-2">300 Above Questions</p>
                        <p>2 Hours</p>
                        <a href="">
                        <button class="btn btn-outline-primary">Click To Start</button>
                        </a>
                        
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
