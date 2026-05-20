package com.example.inventorymanagementsystem.controller;

import com.example.inventorymanagementsystem.dao.ProductDAO;
import com.example.inventorymanagementsystem.model.DurableItem;
import com.example.inventorymanagementsystem.model.Item;
import com.example.inventorymanagementsystem.model.PerishableItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    // Handles CREATE and UPDATE requests coming from your HTML forms
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String type = request.getParameter("itemType");
            String extraAttr = request.getParameter("specialAttribute");

            // Server-side validation
            String addError = null;
            if (name == null || name.trim().isEmpty()) {
                addError = "Product name is required.";
            }

            double price = 0.0;
            if (addError == null) {
                try {
                    price = Double.parseDouble(priceStr);
                    if (price < 0) addError = "Price must be non-negative.";
                } catch (NumberFormatException e) {
                    addError = "Invalid price format.";
                }
            }

            int stock = 0;
            if (addError == null) {
                try {
                    stock = Integer.parseInt(stockStr);
                    if (stock < 0) addError = "Stock must be a non-negative integer.";
                } catch (NumberFormatException e) {
                    addError = "Invalid stock quantity.";
                }
            }

            if (addError == null) {
                if ("PERISHABLE".equalsIgnoreCase(type)) {
                    if (!isValidDate(extraAttr)) addError = "Expiry date must be a valid date in YYYY-MM-DD.";
                } else if ("DURABLE".equalsIgnoreCase(type)) {
                    if (!isValidWarranty(extraAttr)) addError = "Warranty must include a positive number and unit (e.g. '24 Months' or '2 Years').";
                }
            }

            if (addError != null) {
                request.setAttribute("addError", addError);
                // keep user's inputs so the form can repopulate if desired
                request.setAttribute("formName", name);
                request.setAttribute("formPrice", priceStr);
                request.setAttribute("formStock", stockStr);
                request.setAttribute("formType", type);
                request.setAttribute("formAttr", extraAttr);
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            Item newItem = null;
            if ("PERISHABLE".equalsIgnoreCase(type)) {
                // parse and normalize expiry date
                newItem = new PerishableItem(0, name.trim(), price, stock, extraAttr.trim());
            } else if ("DURABLE".equalsIgnoreCase(type)) {
                newItem = new DurableItem(0, name.trim(), price, stock, extraAttr.trim());
            }

            if (newItem != null && productDAO.addProduct(newItem)) {
                response.sendRedirect("product?action=list"); // Redirect to display inventory list
            } else {
                response.getWriter().println("Error adding product to database.");
            }
        } else if ("updateStock".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            String stockStr = request.getParameter("stockLevel");
            String updateError = null;
            int id = 0;
            int newStock = 0;
            try {
                id = Integer.parseInt(idStr);
                if (id <= 0) updateError = "Product ID must be a positive integer.";
            } catch (NumberFormatException e) {
                updateError = "Invalid product ID.";
            }

            if (updateError == null) {
                try {
                    newStock = Integer.parseInt(stockStr);
                    if (newStock < 0) updateError = "New stock must be a non-negative integer.";
                } catch (NumberFormatException e) {
                    updateError = "Invalid stock value.";
                }
            }

            if (updateError != null) {
                request.setAttribute("updateError", updateError);
                request.setAttribute("updateId", idStr);
                request.setAttribute("updateStock", stockStr);
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            if (productDAO.updateStock(id, newStock)) {
                response.sendRedirect("product?action=list");
            } else {
                response.getWriter().println("Error updating stock levels.");
            }
        }
    }

    // Validate YYYY-MM-DD date
    private boolean isValidDate(String s) {
        if (s == null) return false;
        try {
            LocalDate.parse(s);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    // Validate warranty like "24 Months", "3 Years", "24M", etc.
    private boolean isValidWarranty(String s) {
        if (s == null) return false;
        String trimmed = s.trim().toLowerCase();
        Pattern p = Pattern.compile("^(\\d+)\\s*(months?|mos?|m|years?|yrs?|y|mo)$");
        Matcher m = p.matcher(trimmed);
        if (m.find()) {
            try {
                int n = Integer.parseInt(m.group(1));
                return n > 0;
            } catch (NumberFormatException ex) {
                return false;
            }
        }
        return false;
    }

    // Handles READ requests to display information on your web pages
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("list".equalsIgnoreCase(action) || action == null) {
            request.setAttribute("productList", productDAO.getAllProducts());
            request.getRequestDispatcher("/inventory.jsp").forward(request, response);
        }
    }
}

