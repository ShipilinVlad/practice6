package com.example.productapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.sql.DataSource;

/**
 * Конфигурация Spring Security.
 *
 * Аутентификация выполняется через данные из PostgreSQL. Пароли хранятся
 * в базе в виде BCrypt-хэшей, а права определяются ролями ROLE_USER и
 * ROLE_ADMIN.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final DataSource dataSource;

    public SecurityConfig(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * Загружает пользователя и его роли непосредственно из БД.
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(dataSource)
                .passwordEncoder(passwordEncoder())
                .usersByUsernameQuery(
                        "SELECT username, password, enabled " +
                        "FROM users WHERE username = ?"
                )
                .authoritiesByUsernameQuery(
                        "SELECT u.username, r.role_name " +
                        "FROM users u " +
                        "JOIN user_roles ur ON u.id = ur.user_id " +
                        "JOIN roles r ON ur.role_id = r.id " +
                        "WHERE u.username = ?"
                );
    }

    /**
     * Настраивает доступ к URL приложения.
     *
     * Просмотр списка и поиск доступны обычному пользователю.
     * Операции добавления, редактирования и удаления доступны только Admin.
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                    .antMatchers(
                            "/",
                            "/products/",
                            "/register",
                            "/login",
                            "/resources/**",
                            "/css/**"
                    ).permitAll()
                    .antMatchers(
                            "/products/list",
                            "/products/search/**"
                    ).hasAnyRole("USER", "ADMIN")
                    .antMatchers(
                            "/products/add",
                            "/products/edit/**",
                            "/products/delete/**"
                    ).hasRole("ADMIN")
                    .anyRequest().authenticated()
                .and()
                    .formLogin()
                    .loginPage("/login")
                    .loginProcessingUrl("/login")
                    .defaultSuccessUrl("/products/", true)
                    .failureUrl("/login?error=true")
                    .usernameParameter("username")
                    .passwordParameter("password")
                    .permitAll()
                .and()
                    .logout()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/products/")
                    .invalidateHttpSession(true)
                    .deleteCookies("JSESSIONID")
                    .permitAll()
                .and()
                    .exceptionHandling()
                    .accessDeniedPage("/access-denied")
                .and()
                    // Для учебной работы формы POST работают без CSRF-токена.
                    .csrf().disable();
    }

    /**
     * Кодировщик паролей. При регистрации пароль пользователя хэшируется
     * перед записью в PostgreSQL.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
