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

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    // Handles CREATE and UPDATE requests coming from your HTML forms
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String type = request.getParameter("itemType");
            String extraAttr = request.getParameter("specialAttribute");

            Item newItem = null;
            if ("PERISHABLE".equalsIgnoreCase(type)) {
                newItem = new PerishableItem(0, name, price, stock, extraAttr);
            } else if ("DURABLE".equalsIgnoreCase(type)) {
                newItem = new DurableItem(0, name, price, stock, extraAttr);
            }

            if (newItem != null && productDAO.addProduct(newItem)) {
                response.sendRedirect("product?action=list"); // Redirect to display inventory list
            } else {
                response.getWriter().println("Error adding product to database.");
            }
        } else if ("updateStock".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int newStock = Integer.parseInt(request.getParameter("stockLevel"));

            if (productDAO.updateStock(id, newStock)) {
                response.sendRedirect("product?action=list");
            } else {
                response.getWriter().println("Error updating stock levels.");
            }
        }
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

