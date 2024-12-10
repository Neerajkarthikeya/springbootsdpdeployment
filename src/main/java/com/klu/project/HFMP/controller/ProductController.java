package com.klu.project.HFMP.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.klu.project.HFMP.model.Product;
import com.klu.project.HFMP.service.ProductService;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/updateproduct")
    @ResponseBody
    public String updateProduct(@RequestBody Product product) {
        try {
            productService.updateProduct(product);
            return "Product updated successfully";
        } catch (Exception e) {
            return "Error updating product: " + e.getMessage();
        }
    }

    @PostMapping("/deleteproduct")
    @ResponseBody
    public String deleteProduct(@RequestBody Map<String, Integer> request) {
        try {
            int pid = request.get("pid");
            productService.deleteProduct(pid);
            return "Product deleted successfully";
        } catch (Exception e) {
            return "Error deleting product: " + e.getMessage();
        }
    }
//    @GetMapping("addproduct")
//    public ModelAndView addProduct() {
//        return new ModelAndView("addproduct");
//    }

    @GetMapping("viewallproducts1")
    public ModelAndView viewAllProducts() {
        List<Product> productList = productService.ViewAllProducts();
        ModelAndView mv = new ModelAndView("viewallproducts");
        mv.addObject("products", productList);
        return mv;
    }

//    @PostMapping("insertproduct")
//    public ModelAndView insertProduct(HttpServletRequest request, @RequestParam("pimage") MultipartFile file) {
//        ModelAndView mv = new ModelAndView();
//
//        try {
//            // Get form data
//            String name = request.getParameter("pname");
//            String description = request.getParameter("pdescription");
//            Double cost = Double.valueOf(request.getParameter("pcost"));
//
//            // Convert image file to Blob
//            byte[] bytes = file.getBytes();
//            Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
//
//            // Populate the Product model
//            Product product = new Product();
//            product.setPname(name);
//            product.setPdescription(description);
//            product.setPcost(cost);
//            product.setImage(blob);
//
//            // Call service to add product
//            productService.AddProduct(product);
//
//            // Redirect to admin.jsp with success message
//            mv.setViewName("admin");
//            mv.addObject("message", "Product added successfully!");
//
//        } catch (Exception e) {
//            // Handle exception and redirect with error message
//            mv.setViewName("admin");
//            mv.addObject("message", "Error adding product: " + e.getMessage());
//        }
//
//        return mv;
//    }
//    @GetMapping("/dashboard")
//    public String getProductList(Model model) {
//        List<Product> products = productService.ViewAllProducts();  // Fetch all products from database
//        model.addAttribute("products", products);
//        return "customersdashboard";  // Return the view name (dashboard.jsp)
//    }
//    

}
