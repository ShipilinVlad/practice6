package com.example.productapp.dao;

import com.example.productapp.model.User;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Optional;

/**
 * JDBC-реализация работы с пользователями.
 */
@Repository
public class JdbcUserDao implements UserDao {

    private final JdbcTemplate jdbcTemplate;

    public JdbcUserDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    private final RowMapper<User> userRowMapper = (rs, rowNum) -> {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEnabled(rs.getBoolean("enabled"));
        return user;
    };

    /**
     * Добавляет пользователя и автоматически назначает ему ROLE_USER.
     */
    @Override
    public User insert(User user) {
        String sql = "INSERT INTO users (username, password, enabled) VALUES (?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    sql,
                    Statement.RETURN_GENERATED_KEYS
            );

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setBoolean(3, user.isEnabled());

            return ps;
        }, keyHolder);

        if (keyHolder.getKeys() == null || !keyHolder.getKeys().containsKey("id")) {
            throw new IllegalStateException(
                    "Не удалось получить ID созданного пользователя"
            );
        }

        Number id = (Number) keyHolder.getKeys().get("id");
        user.setId(id.intValue());

        // Каждый зарегистрированный пользователь получает ROLE_USER.
        addRoleToUser(user.getId(), "ROLE_USER");

        return user;
    }

    @Override
    public Optional<User> findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try {
            User user = jdbcTemplate.queryForObject(sql, userRowMapper, username);
            return Optional.ofNullable(user);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    @Override
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }

    private void addRoleToUser(Integer userId, String roleName) {
        String sql = "INSERT INTO user_roles (user_id, role_id) " +
                "VALUES (?, (SELECT id FROM roles WHERE role_name = ?))";

        int rows = jdbcTemplate.update(sql, userId, roleName);

        if (rows != 1) {
            throw new IllegalStateException(
                    "Не удалось назначить роль " + roleName + " пользователю с id=" + userId
            );
        }
    }
}
