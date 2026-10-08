<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Добавить продукт</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error {
            color: #f44336;
            font-size: 14px;
            margin-top: 5px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #757575;
            color: white;
            text-decoration: none;
            display: inline-block;
            padding: 9px 20px;
        }
        .form-actions {
            margin-top: 20px;
        }
        .admin-notice {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Добавить новый продукт</h1>

        <sec:authorize access="hasRole('ADMIN')">
            <div class="admin-notice">
                🤖 Вы добавляете продукт как администратор
            </div>
        </sec:authorize>

        <a href="<c:url value='/products/list'/>" class="btn-cancel">Назад к списку</a>

        <form:form method="post" modelAttribute="product">
            <div class="form-group">
                <label for="name">Название:</label>
                <form:input path="name" id="name" />
                <form:errors path="name" cssClass="error" />
            </div>

            <div class="form-group">
                <label for="category">Категория:</label>
                <form:input path="category" id="category" />
                <form:errors path="category" cssClass="error" />
            </div>

            <div class="form-group">
                <label for="manufacturer">Производитель:</label>
                <form:input path="manufacturer" id="manufacturer" />
                <form:errors path="manufacturer" cssClass="error" />
            </div>

            <div class="form-group">
                <label for="price">Цена:</label>
                <form:input path="price" id="price" type="number" step="0.01" />
                <form:errors path="price" cssClass="error" />
            </div>

            <div class="form-group">
                <label for="calories">Калории:</label>
                <form:input path="calories" id="calories" type="number" />
                <form:errors path="calories" cssClass="error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-submit">Добавить</button>
                <a href="<c:url value='/products/list'/>" class="btn-cancel">Отмена</a>
            </div>
        </form:form>

        <sec:authorize access="isAuthenticated()">
            <div style="margin-top: 20px; text-align: right;">
                <form action="${pageContext.request.contextPath}/logout" method="post">
                    <button type="submit" style="background-color: #f44336; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer;">
                        Выйти из системы
                    </button>
                </form>
            </div>
        </sec:authorize>
    </div>
</body>
</html>