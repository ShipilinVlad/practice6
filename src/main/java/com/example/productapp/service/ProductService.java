package com.example.productapp.service;

import com.example.productapp.dao.ProductDao;
import com.example.productapp.model.Product;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductService {

    private final ProductDao productDao;

    public ProductService(ProductDao productDao) {
        this.productDao = productDao;
    }

    public Product createProduct(Product product) {
        // Проверка 1: цена не может быть нулевой для высококалорийных продуктов
        if (product.getCalories() > 500 && product.getPrice() <= 0) {
            throw new IllegalArgumentException("Высококалорийные продукты не могут иметь нулевую цену");
        }

        // Проверка 2: уникальность названия (дополнительная бизнес-логика)
        List<Product> existing = productDao.findByNameLike(product.getName());
        if (!existing.isEmpty()) {
            // Можно добавить предупреждение или логику для дубликатов
        }

        return productDao.insert(product);
    }

    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    public Optional<Product> getProductById(int id) {
        return productDao.findById(id);
    }

    public boolean updateProduct(Product product) {
        return productDao.update(product);
    }

    public boolean deleteProduct(int id) {
        return productDao.deleteById(id);
    }

    public List<Product> searchProductsByName(String name) {
        return productDao.findByNameLike(name);
    }

    public List<Product> searchProductsByPrice(double minPrice) {
        return productDao.findByPriceGreaterThan(minPrice);
    }
}