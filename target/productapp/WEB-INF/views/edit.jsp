<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Редактировать продукт</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        h1 { color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .error { color: #f44336; font-size: 14px; margin-top: 5px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px; }
        .btn-submit { background-color: #4CAF50; color: white; }
        .btn-cancel { background-color: #757575; color: white; text-decoration: none; display: inline-block; padding: 9px 20px; }
        .form-actions { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Редактировать продукт</h1>

        <a href="<c:url value='/products/list'/>" class="btn-cancel">Назад к списку</a>

        <form:form method="post" modelAttribute="product">
            <form:hidden path="id" />

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
                <button type="submit" class="btn btn-submit">Сохранить</button>
                <a href="<c:url value='/products/list'/>" class="btn-cancel">Отмена</a>
            </div>
        </form:form>
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