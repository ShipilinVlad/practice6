<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Вход в систему</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
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
        .btn-login {
            background-color: #4CAF50;
            color: white;
        }
        .error {
            color: #f44336;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Вход в систему</h1>

        <c:if test="${param.error != null}">
            <div class="error">Неверное имя пользователя или пароль</div>
        </c:if>

        <c:if test="${param.logout != null}">
            <div class="success">Вы успешно вышли из системы</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="success">${successMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <input type="text" id="username" name="username" required />
            </div>

            <div class="form-group">
                <label for="password">Пароль:</label>
                <input type="password" id="password" name="password" required />
            </div>

            <button type="submit" class="btn btn-login">Войти</button>
        </form>

        <div style="text-align: center; margin-top: 20px;">
            <a href="<c:url value='/register'/>">Регистрация</a> |
            <a href="<c:url value='/products/'/>">На главную</a>
        </div>
    </div>
</body>
</html>