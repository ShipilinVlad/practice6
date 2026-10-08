package com.example.productapp.controller;

import com.example.productapp.model.User;
import com.example.productapp.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * Контроллер регистрации, входа и страницы отказа в доступе.
 */
@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Программно созданная форма входа.
     * Саму проверку логина и пароля выполняет Spring Security.
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    /**
     * Регистрация обычного пользователя. Роль администратора через эту форму
     * получить нельзя: новый пользователь всегда получает ROLE_USER.
     */
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute User user,
                               BindingResult bindingResult,
                               RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "register";
        }

        try {
            userService.registerUser(user);
            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Регистрация успешна! Теперь вы можете войти в систему."
            );
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/register";
        } catch (Exception e) {
            e.printStackTrace();

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Ошибка при регистрации: " + e.getMessage()
            );

            return "redirect:/register";
        }
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}
