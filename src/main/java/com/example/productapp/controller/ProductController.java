package com.example.productapp.controller;

import com.example.productapp.model.Product;
import com.example.productapp.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // Главная страница
    @GetMapping("/")
    public String home() {
        return "index";
    }

    // Страница просмотра всех продуктов
    @GetMapping("/list")
    public String listProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "list";
    }

    // Страница добавления продукта
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        return "add";
    }

    // Обработка добавления продукта
    @PostMapping("/add")
    public String addProduct(@Valid @ModelAttribute Product product,
                             BindingResult bindingResult,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "add";
        }

        try {
            productService.createProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Продукт успешно добавлен!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/products/add";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при добавлении продукта");
            return "redirect:/products/add";
        }

        return "redirect:/products/list";
    }

    // Страница редактирования продукта
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("Неверный ID продукта: " + id));
        model.addAttribute("product", product);
        return "edit";
    }

    // Обработка редактирования продукта
    @PostMapping("/edit/{id}")
    public String updateProduct(@PathVariable int id,
                                @Valid @ModelAttribute Product product,
                                BindingResult bindingResult,
                                RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "edit";
        }

        product.setId(id);
        boolean updated = productService.updateProduct(product);

        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "Продукт успешно обновлен!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Не удалось обновить продукт");
        }

        return "redirect:/products/list";
    }

    // Страница удаления продукта
    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable int id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("Неверный ID продукта: " + id));
        model.addAttribute("product", product);
        return "delete";
    }

    // Обработка удаления продукта
    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable int id, RedirectAttributes redirectAttributes) {
        boolean deleted = productService.deleteProduct(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Продукт успешно удален!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Не удалось удалить продукт");
        }

        return "redirect:/products/list";
    }

    // Страница поиска по названию
    @GetMapping("/search/name")
    public String showSearchByNameForm() {
        return "search-name";
    }

    // Обработка поиска по названию
    @PostMapping("/search/name")
    public String searchByName(@RequestParam String name, Model model) {
        List<Product> products = productService.searchProductsByName(name);
        model.addAttribute("products", products);
        model.addAttribute("searchQuery", name);
        return "search-results";
    }

    // Страница поиска по цене
    @GetMapping("/search/price")
    public String showSearchByPriceForm() {
        return "search-price";
    }

    // Обработка поиска по цене
    @PostMapping("/search/price")
    public String searchByPrice(@RequestParam double minPrice, Model model) {
        List<Product> products = productService.searchProductsByPrice(minPrice);
        model.addAttribute("products", products);
        model.addAttribute("minPrice", minPrice);
        return "search-results";
    }
}