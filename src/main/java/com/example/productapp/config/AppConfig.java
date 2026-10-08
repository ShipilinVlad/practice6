package com.example.productapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import javax.sql.DataSource;
import javax.validation.Validator;

/**
 * Корневая конфигурация приложения.
 *
 * Здесь создается DataSource для PostgreSQL и подключается компонентная модель
 * приложения. Параметры БД можно передать через системные свойства Java:
 * db.url, db.user и db.pass.
 */
@Configuration
@ComponentScan("com.example.productapp")
public class AppConfig {

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource ds = new DriverManagerDataSource();

        ds.setDriverClassName("org.postgresql.Driver");
        ds.setUrl(System.getProperty(
                "db.url",
                "jdbc:postgresql://localhost:5432/productdb?useUnicode=true&characterEncoding=UTF-8"
        ));
        ds.setUsername(System.getProperty("db.user", "postgres"));
        ds.setPassword(System.getProperty("db.pass", "postgres"));

        return ds;
    }

    @Bean
    public Validator validator() {
        return new LocalValidatorFactoryBean();
    }
}
