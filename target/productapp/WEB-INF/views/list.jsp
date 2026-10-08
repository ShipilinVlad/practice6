<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Список продуктов</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
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
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .btn {
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            margin: 0 5px;
        }
        .btn-add {
            background-color: #2196F3;
            color: white;
        }
        .btn-edit {
            background-color: #FF9800;
            color: white;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        .btn-home {
            background-color: #757575;
            color: white;
        }
        .actions {
            white-space: nowrap;
        }
        .welcome-message {
            background-color: #e8f5e9;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Список продуктов</h1>

        <sec:authorize access="isAuthenticated()">
            <div class="welcome-message">
                👋 Добро пожаловать, <sec:authentication property="principal.username" />!
            </div>
        </sec:authorize>

        <c:if test="${not empty successMessage}">
            <div class="success">${successMessage}</div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>

        <div style="margin: 20px 0;">
            <a href="<c:url value='/products/'/>" class="btn btn-home">На главную</a>

            <sec:authorize access="hasRole('ADMIN')">
                <a href="<c:url value='/products/add'/>" class="btn btn-add">Добавить продукт</a>
            </sec:authorize>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <p>Нет продуктов в базе данных.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Название</th>
                            <th>Категория</th>
                            <th>Производитель</th>
                            <th>Цена</th>
                            <th>Калории</th>
                            <th>Действия</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.category}</td>
                                <td>${product.manufacturer}</td>
                                <td>${product.price}</td>
                                <td>${product.calories}</td>
                                <td class="actions">
                                    <sec:authorize access="hasRole('ADMIN')">
                                        <a href="<c:url value='/products/edit/${product.id}'/>" class="btn btn-edit">Редактировать</a>
                                        <a href="<c:url value='/products/delete/${product.id}'/>" class="btn btn-delete">Удалить</a>
                                    </sec:authorize>
                                    <sec:authorize access="!hasRole('ADMIN')">
                                        <span style="color: #999;">Только для просмотра</span>
                                    </sec:authorize>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

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