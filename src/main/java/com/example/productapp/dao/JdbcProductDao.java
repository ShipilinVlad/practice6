package com.example.productapp.dao;

import com.example.productapp.model.Product;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

@Repository
public class JdbcProductDao implements ProductDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcProductDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    private final RowMapper<Product> productRowMapper = (rs, rowNum) -> {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setCategory(rs.getString("category"));
        product.setManufacturer(rs.getString("manufacturer"));
        product.setPrice(rs.getDouble("price"));
        product.setCalories(rs.getInt("calories"));
        return product;
    };

    @Override
    public Product insert(Product product) {
        String sql = "INSERT INTO product (name, category, manufacturer, price, calories) VALUES (?, ?, ?, ?, ?) RETURNING id";
        Integer id = jdbcTemplate.queryForObject(sql, Integer.class,
                product.getName(),
                product.getCategory(),
                product.getManufacturer(),
                product.getPrice(),
                product.getCalories());
        product.setId(id);
        return product;
    }

    @Override
    public List<Product> findAll() {
        String sql = "SELECT * FROM product ORDER BY id";
        return jdbcTemplate.query(sql, productRowMapper);
    }

    @Override
    public Optional<Product> findById(int id) {
        String sql = "SELECT * FROM product WHERE id = ?";
        try {
            Product product = jdbcTemplate.queryForObject(sql, productRowMapper, id);
            return Optional.ofNullable(product);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    @Override
    public boolean update(Product product) {
        String sql = "UPDATE product SET name = ?, category = ?, manufacturer = ?, price = ?, calories = ? WHERE id = ?";
        int rows = jdbcTemplate.update(sql,
                product.getName(),
                product.getCategory(),
                product.getManufacturer(),
                product.getPrice(),
                product.getCalories(),
                product.getId());
        return rows > 0;
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM product WHERE id = ?";
        int rows = jdbcTemplate.update(sql, id);
        return rows > 0;
    }

    @Override
    public List<Product> findByNameLike(String namePart) {
        String sql = "SELECT * FROM product WHERE LOWER(name) LIKE LOWER(?) ORDER BY name";
        return jdbcTemplate.query(sql, productRowMapper, "%" + namePart + "%");
    }

    @Override
    public List<Product> findByPriceGreaterThan(double price) {
        String sql = "SELECT * FROM product WHERE price > ? ORDER BY price";
        return jdbcTemplate.query(sql, productRowMapper, price);
    }
}