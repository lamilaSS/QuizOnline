<%-- 
    Document   : manage
    Created on : Feb 6, 2021, 3:11:13 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <c:set var="questionList" value="${requestScope.LIST_QUESTION}"/>
            <c:if test="${not empty questionList}">
                <div class="row mb-2">
                    <div class="col-lg-12">
                        <c:url var="create" value="getSubject">
                            <c:param name="subjectID" value="${requestScope.SUBJECTID}"/>
                        </c:url>
                        <a class="btn btn-primary" href="${create}">
                            <i class="fas fa-plus"></i> Create New Question
                        </a>
                    </div>
                </div>
                <c:forEach var="dto" items="${questionList}" varStatus="counter">
                    <div class="row mb-2">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Question ${counter.count}: ${dto.content}</h5>
                                    <div class="ml-3" style="min-height: 100px;">
                                        <c:set var="listAnswer" value="${dto.answerList}"/>
                                        <c:if test="${not empty listAnswer}">
                                            <c:forEach var="answer" items="${listAnswer}">
                                                Answer: ${answer.answerContent}
                                                <br>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-9"></div>
                                        <div class="col-lg-3 text-center">
                                            <c:url var="update" value="get">
                                                <c:param name="questionID" value="${dto.questionID}"/>
                                            </c:url>
                                            <a href="${update}" class="btn btn-success">Update</a>

                                            <c:url var="delete" value="delete">
                                                <c:param name="questionID" value="${dto.questionID}"/>
                                            </c:url>
                                            <a href="${delete}" 
                                               <c:if test="${dto.statusID == 1}">
                                                   class="btn btn-warning disabled"
                                               </c:if>
                                               <c:if test="${dto.statusID != 1}">
                                                   class="btn btn-warning"
                                               </c:if>
                                               />Delete</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty questionList}">
                <div class="text-center">

                    <c:url var="create" value="getSubject">
                        <c:param name="subjectID" value="${requestScope.SUBJECTID}"/>
                    </c:url>

                    <h2>No question with this subject</h2>
                    <p>Please create new question <a href="${create}">Create</a></p>
                </div>
            </c:if>
        </div>
    </body>
</html>
