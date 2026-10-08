<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Поиск по названию</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        h1 { color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px; }
        .btn-submit { background-color: #2196F3; color: white; }
        .btn-cancel { background-color: #757575; color: white; text-decoration: none; display: inline-block; padding: 9px 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Поиск продуктов по названию</h1>

        <a href="<c:url value='/products/'/>" class="btn-cancel">На главную</a>
        <a href="<c:url value='/products/list'/>" class="btn-cancel" style="margin-left: 10px;">К списку продуктов</a>

        <form method="post" action="<c:url value='/products/search/name'/>">
            <div class="form-group">
                <label for="name">Введите часть названия:</label>
                <input type="text" id="name" name="name" required placeholder="Например: яблоко" />
            </div>
            <button type="submit" class="btn btn-submit">Найти</button>
        </form>
    </div>
    <sec:authorize access="isAuthenticated()">
        <div style="margin-top: 20px; text-align: right;">
            <form action="${pageContext.request.contextPath}/logout" method="post">
                <button type="submit" style="background-color: #f44336; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer;">
                    Выйти из системы
                </button>
            </form>
        </div>
    </sec:authorize>
</body>
</html>