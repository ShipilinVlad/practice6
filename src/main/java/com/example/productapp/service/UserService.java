package com.example.productapp.service;

import com.example.productapp.dao.UserDao;
import com.example.productapp.model.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * Сервис регистрации пользователей.
 */
@Service
@Transactional
public class UserService {

    private final UserDao userDao;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserDao userDao, PasswordEncoder passwordEncoder) {
        this.userDao = userDao;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * Проверяет уникальность логина, хэширует пароль и сохраняет пользователя.
     * Роль ROLE_USER назначается в DAO после создания записи.
     */
    public User registerUser(User user) {
        if (userDao.existsByUsername(user.getUsername())) {
            throw new IllegalArgumentException("Пользователь с таким именем уже существует");
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setEnabled(true);

        return userDao.insert(user);
    }

    public Optional<User> findByUsername(String username) {
        return userDao.findByUsername(username);
    }
}
