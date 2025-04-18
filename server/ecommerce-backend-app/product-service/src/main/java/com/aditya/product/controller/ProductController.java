package com.aditya.product.controller;

import com.aditya.product.dtos.ProductDto;
import com.aditya.product.services.ProductService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/v1/products")
@Tag(name = "Products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping
    //@PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<ProductDto> createProduct(@RequestBody @Valid ProductDto productDto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(productService.addProduct(productDto));
    }

    @PostMapping("/{productId}/category/{categoryId}")
    public ResponseEntity<Void> addCategoryToProduct(@PathVariable UUID productId, @PathVariable UUID categoryId) {
        productService.addCategoryToProduct(productId,categoryId);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductDto> getProductById(@PathVariable UUID id) {
        return ResponseEntity.ok(productService.getProductById(id));

    }

    @GetMapping
    public ResponseEntity<Page<ProductDto>> getAllProducts(Pageable pageable) {
        Page<ProductDto> products = productService.getAllProduct(pageable);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/search/{keyword}")
    ResponseEntity<List<ProductDto>> searchProductsByKeyword(@PathVariable String keyword) {
        return ResponseEntity.status(HttpStatus.OK).body(productService.searchProduct(keyword));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> deleteProduct(@PathVariable UUID id) {
        ProductDto productDto = productService.getProductById(id);
        productService.deleteProductById(id);
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Product deleted successfully");
        response.put("deletedProduct", productDto);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).body(response);
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteAllProducts() {
        productService.deleteAllProducts();
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{productId}/category/{categoryId}")
    public ResponseEntity<Void> removeCategoryFromProduct(@PathVariable UUID productId, @PathVariable UUID categoryId) {
        productService.removeCategoryFromProduct(productId,categoryId);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductDto> updateProduct(@PathVariable UUID id, @RequestBody @Valid ProductDto productDto) {
        ProductDto updatedProduct = productService.updateProduct(productDto, id);
        return ResponseEntity.ok(updatedProduct);
    }
}
