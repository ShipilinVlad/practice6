<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Удалить продукт</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        h1 { color: #333; }
        .product-details { background-color: #f9f9f9; padding: 20px; border-radius: 5px; margin: 20px 0; }
        .product-details p { margin: 10px 0; font-size: 16px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-cancel { background-color: #757575; color: white; text-decoration: none; display: inline-block; padding: 9px 20px; }
        .form-actions { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Удалить продукт</h1>

        <p>Вы уверены, что хотите удалить следующий продукт?</p>

        <div class="product-details">
            <p><strong>ID:</strong> ${product.id}</p>
            <p><strong>Название:</strong> ${product.name}</p>
            <p><strong>Категория:</strong> ${product.category}</p>
            <p><strong>Производитель:</strong> ${product.manufacturer}</p>
            <p><strong>Цена:</strong> ${product.price}</p>
            <p><strong>Калории:</strong> ${product.calories}</p>
        </div>

        <form:form method="post">
            <div class="form-actions">
                <button type="submit" class="btn btn-delete">Да, удалить</button>
                <a href="<c:url value='/products/list'/>" class="btn-cancel">Нет, отмена</a>
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