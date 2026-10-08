<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Регистрация</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
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
        .btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn-register {
            background-color: #4CAF50;
            color: white;
        }
        .btn-login {
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            display: block;
            text-align: center;
            padding: 10px;
            margin-top: 10px;
        }
        .error {
            color: #f44336;
            font-size: 14px;
            margin-top: 5px;
        }
        .form-error {
            color: #f44336;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1>Регистрация</h1>

        <c:if test="${not empty errorMessage}">
            <div class="form-error">${errorMessage}</div>
        </c:if>

        <form:form method="post" modelAttribute="user">
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <form:input path="username" id="username" />
                <form:errors path="username" cssClass="error" />
            </div>

            <div class="form-group">
                <label for="password">Пароль:</label>
                <form:password path="password" id="password" />
                <form:errors path="password" cssClass="error" />
                <small style="color: #666;">Минимум 6 символов</small>
            </div>

            <button type="submit" class="btn btn-register">Зарегистрироваться</button>
        </form:form>

        <div class="login-link">
            <p>Уже есть аккаунт?</p>
            <a href="<c:url value='/login'/>" class="btn-login">Войти в систему</a>
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <a href="<c:url value='/products/'/>">Вернуться на главную</a>
        </div>
    </div>
</body>
</html>