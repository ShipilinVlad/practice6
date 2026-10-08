package com.example.productapp.dao;

import com.example.productapp.model.Product;
import java.util.List;
import java.util.Optional;

public interface ProductDao {
    Product insert(Product product);
    List<Product> findAll();
    Optional<Product> findById(int id);
    boolean update(Product product);
    boolean deleteById(int id);
    List<Product> findByNameLike(String namePart);
    List<Product> findByPriceGreaterThan(double price);
}