<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Главная - ProductApp</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
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
        .user-info {
            background-color: #e3f2fd;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info span {
            font-weight: bold;
            color: #1565c0;
        }
        .menu {
            margin: 30px 0;
        }
        .menu ul {
            list-style-type: none;
            padding: 0;
        }
        .menu li {
            margin: 10px 0;
        }
        .menu a {
            display: block;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            border: 1px solid #ddd;
            transition: background-color 0.3s;
        }
        .menu a:hover {
            background-color: #e0e0e0;
        }
        .auth-links {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .auth-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #2196F3;
        }
        .btn-logout {
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .admin-menu {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .admin-menu h3 {
            color: #856404;
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Добро пожаловать в ProductApp</h1>
        <p>Веб-приложение для управления продуктами</p>

        <sec:authorize access="isAuthenticated()">
            <div class="user-info">
                <div>
                    👤 Вы вошли как: <span><sec:authentication property="principal.username" /></span>
                </div>
                <div>
                    <form action="${pageContext.request.contextPath}/logout" method="post">
                        <button type="submit" class="btn-logout">Выйти</button>
                    </form>
                </div>
            </div>
        </sec:authorize>

        <sec:authorize access="hasRole('ADMIN')">
            <div class="admin-menu">
                <h3>🤖 Панель администратора</h3>
                <p>У вас есть права администратора для управления продуктами.</p>
            </div>
        </sec:authorize>

        <div class="menu">
            <h2>Меню:</h2>
            <ul>
                <li><a href="<c:url value='/products/list'/>">📋 Просмотр всех продуктов</a></li>
                <li><a href="<c:url value='/products/search/name'/>">🔍 Поиск по названию</a></li>
                <li><a href="<c:url value='/products/search/price'/>">💰 Поиск по цене</a></li>

                <sec:authorize access="hasRole('ADMIN')">
                    <li><a href="<c:url value='/products/add'/>">➕ Добавить новый продукт</a></li>
                </sec:authorize>
            </ul>
        </div>

        <div class="auth-links">
            <sec:authorize access="!isAuthenticated()">
                <a href="<c:url value='/login'/>">Вход в систему</a>
                <a href="<c:url value='/register'/>">Регистрация</a>
            </sec:authorize>
        </div>
    </div>
</body>
</html>