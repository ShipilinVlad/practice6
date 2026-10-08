package com.example.productapp.model;

import javax.validation.constraints.*;
import java.util.Objects;

public class Product {
    private Integer id;

    @NotBlank(message = "Название обязательно")
    @Size(min = 2, max = 100, message = "Название должно быть от 2 до 100 символов")
    private String name;

    @NotBlank(message = "Категория обязательна")
    @Size(min = 2, max = 50, message = "Категория должна быть от 2 до 50 символов")
    private String category;

    @NotBlank(message = "Производитель обязателен")
    @Size(min = 2, max = 100, message = "Производитель должен быть от 2 до 100 символов")
    private String manufacturer;

    @NotNull(message = "Цена обязательна")
    @DecimalMin(value = "0.01", message = "Цена должна быть больше 0")
    @DecimalMax(value = "1000000.00", message = "Цена не должна превышать 1,000,000")
    @Digits(integer = 10, fraction = 2, message = "Неверный формат цены")
    private Double price;

    @NotNull(message = "Калории обязательны")
    @Min(value = 1, message = "Калории должны быть положительными")
    @Max(value = 100000, message = "Калории не должны превышать 100,000")
    private Integer calories;

    public Product() {}

    public Product(Integer id, String name, String category, String manufacturer, Double price, Integer calories) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.manufacturer = manufacturer;
        this.price = price;
        this.calories = calories;
    }

    // Геттеры и сеттеры
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name != null ? name.trim() : "";
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category != null ? category.trim() : "";
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer != null ? manufacturer.trim() : "";
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getCalories() {
        return calories;
    }

    public void setCalories(Integer calories) {
        this.calories = calories;
    }

    @Override
    public String toString() {
        return String.format("Product{id=%d, name='%s', category='%s', manufacturer='%s', price=%.2f, calories=%d}",
                id, name, category, manufacturer, price, calories);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return Objects.equals(id, product.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}