<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Доступ запрещен</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #f44336;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        .btn-home {
            background-color: #4CAF50;
            color: white;
        }
        .btn-login {
            background-color: #2196F3;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⛔ Доступ запрещен</h1>
        <p>У вас нет прав для доступа к этой странице.</p>
        <p>Пожалуйста, обратитесь к администратору для получения необходимых прав.</p>

        <div style="margin-top: 30px;">
            <a href="<c:url value='/products/'/>" class="btn btn-home">На главную</a>
            <a href="<c:url value='/login'/>" class="btn btn-login">Войти под другим пользователем</a>
        </div>
    </div>
</body>
</html>