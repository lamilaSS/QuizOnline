<%-- 
    Document   : quiz
    Created on : Jan 30, 2021, 9:22:47 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Take Quiz</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
        <style>
            .slideshow-container {
                max-width: 100%;
                position: relative;
                margin: auto;
            }
            .slides {display: none;} 
            .active, .dot:hover {
                color: white;
                background-color: #0062cc;
                
            }

        </style>
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <c:set var="listQuestion" value="${requestScope.QUESTION_LIST}"/>
            <c:set var="sdto" value="${requestScope.SUBJECT}"/>
            <div class="py-5">
                <c:if test="${not empty listQuestion && not empty sdto}">
                    <div class="row">
                        <div class="col-lg-3 ">
                            <div class="card px-3 py-3" style="min-height: 200px;">
                                <div class="card-body">
                                    <h5 class="card-title">${sdto.subjectName}</h5>
                                    <p class="card-text">Time: <span id="time">${sdto.time}</span></p>
                                    <div class="row">
                                        <c:forEach var="question" items="${listQuestion}" varStatus="counter">
                                            <div class="col-lg-2">
                                                <span 
                                                      style="
                                                      color:black;
                                                      border:1px solid #007bff;
                                                      text-align:center;
                                                      vertical-align:middle;
                                                      border-radius: 25%;
                                                      padding: 10px;
                                                      cursor: pointer;
                                                      "
                                                      class= "dot"
                                                      onclick="currentSlide(${counter.count})"
                                                      >
                                                    ${counter.count}
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <form name="exam" action="checkAnswer" method="post">
                                <c:forEach var="question" items="${listQuestion}" varStatus="counter">
                                    <div class="slideshow-container">
                                        <div class="card mb-3 slides " style="min-height:  200px;">
                                            <div class="card-body ml-3">
                                                <h5 class="card-title">Question ${counter.count}: ${question.content}</h5>
                                                <c:set var="listAnswer" value="${question.answerList}"/>
                                                <c:forEach var="answer" items="${listAnswer}">
                                                    <input class="form-check-input" type="radio" name="answer${question.questionID}" value="${answer.answerID}" id="${answer.answerID}">
                                                    <label class="form-check-label" for="${answer.answerID}">
                                                        ${answer.answerContent}
                                                    </label>
                                                    <br>
                                                </c:forEach>
                                            </div>

                                        </div>
                                    </div>

                                    <script>
                                        var slideIndex = 1;
                                        showSlides(slideIndex);

                                        function plusSlides(n) {
                                            showSlides(slideIndex += n);
                                        }

                                        function currentSlide(n) {
                                            showSlides(slideIndex = n);
                                        }

                                        function showSlides(n, id) {
                                            var i;
                                            var slides = document.getElementsByClassName("slides");
                                            var dots = document.getElementsByClassName("dot");
                                            if (n > slides.length) {
                                                slideIndex = 1
                                            }
                                            if (n < 1) {
                                                slideIndex = slides.length
                                            }
                                            for (i = 0; i < slides.length; i++) {
                                                slides[i].style.display = "none";
                                            }
                                            for (i = 0; i < dots.length; i++) {
                                                dots[i].className = dots[i].className.replace(" active", "");
                                            }
                                            slides[slideIndex - 1].style.display = "block";
                                            dots[slideIndex - 1].className += " active";
                                        }
                                    </script>
                                    <input type="hidden" name="questionID" value="${question.questionID}" />

                                </c:forEach>
                                <div class="pagination justify-content-end">
                                    <a class="btn btn-success" onclick="plusSlides(-1)">&#10094;</a>
                                    <a class="btn btn-success" onclick="plusSlides(1)" >&#10095;</a>
                                </div>

                                <br>
                                <div class="row">
                                    <div class="col-lg-10"></div>
                                    <div class="col-lg-2">
                                        <input type="hidden" name="subjectID" value="${requestScope.SUBJECTID}" />
                                        <input type="submit" value="Finish" class="btn btn-success mb-3" style="width: 100%"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty listQuestion && not empty sdto}">
                    <div class="text-center">
                        <div class="">
                            <h5 class="">${sdto.subjectName}</h5>
                            <h6 class="mb-2 text-muted">${sdto.cdto.categoryName}</h6>
                            <a href="subject" class="card-link">Back To Home Page</a>
                        </div>
                    </div>
                </c:if>

            </div>
            <script>
                var time = document.getElementById("time").innerHTML;
                var min = parseInt(time.split(":", 1));
                var sec = parseInt(time.split(":").pop());
                var examTime = min * 60 + sec;
                function startTimer(duration, display) {
                    var timer = duration;
                    var minutes, seconds;
                    var form = document.forms.exam;

                    var t = setInterval(function () {
                        minutes = parseInt(timer / 60, 10);
                        seconds = parseInt(timer % 60, 10);
                        minutes = minutes < 10 ? "0" + minutes : minutes;
                        seconds = seconds < 10 ? "0" + seconds : seconds;

                        display.textContent = minutes + ":" + seconds;

                        if (--timer <= 0) {
                            timer = duration;

                            if (!isNaN(t))
                                clearInterval(t);

                            // submit the form...
                            form.submit();
                        }
                    }, 1000);
                }

                window.onload = function () {
                    var display = document.querySelector('#time');
                    startTimer(examTime, display);
                };
            </script>
    </body>
</html>
