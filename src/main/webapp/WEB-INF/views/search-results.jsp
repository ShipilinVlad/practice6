<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Результаты поиска</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: #333; }
        .search-info { background-color: #e3f2fd; padding: 10px; margin: 10px 0; border-radius: 5px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .btn { padding: 8px 15px; text-decoration: none; border-radius: 4px; margin: 0 5px; }
        .btn-home { background-color: #757575; color: white; }
        .no-results { padding: 20px; background-color: #fff3cd; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Результаты поиска</h1>
        <sec:authorize access="isAuthenticated()">
            <div class="welcome-message" style="background-color: #e8f5e9; padding: 10px; border-radius: 5px; margin-bottom: 20px; font-style: italic;">
                👋 Добро пожаловать, <sec:authentication property="principal.username" />!
            </div>
        </sec:authorize>

        <c:if test="${not empty searchQuery}">
            <div class="search-info">
                Поиск по названию: "<strong>${searchQuery}</strong>"
            </div>
        </c:if>

        <c:if test="${not empty minPrice}">
            <div class="search-info">
                Минимальная цена: <strong>${minPrice}</strong>
            </div>
        </c:if>

        <a href="<c:url value='/products/'/>" class="btn btn-home">На главную</a>
        <a href="<c:url value='/products/list'/>" class="btn btn-home" style="margin-left: 10px;">К списку продуктов</a>

        <c:choose>
            <c:when test="${empty products}">
                <div class="no-results">
                    <p>По вашему запросу ничего не найдено.</p>
                </div>
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
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>