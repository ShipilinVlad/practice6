package com.example.productapp.dao;

import com.example.productapp.model.User;
import java.util.Optional;

public interface UserDao {
    User insert(User user);
    Optional<User> findByUsername(String username);
    boolean existsByUsername(String username);
}