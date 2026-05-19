<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.inventorymanagementsystem.model.Item" %>
<%@ page import="com.example.inventorymanagementsystem.model.PerishableItem" %>
<%@ page import="com.example.inventorymanagementsystem.model.DurableItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Current Inventory Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-success">Current Stock Inventory</h2>
            <a href="index.jsp" class="btn btn-outline-primary">Back to Management Panel</a>
        </div>

        <table class="table table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Unit Price</th>
                <th>Available Stock</th>
                <th>Item Classification</th>
                <th>Special Attribute Log</th>
                <th>Total Asset Value</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Item> products = (List<Item>) request.getAttribute("productList");
                if (products != null && !products.isEmpty()) {
                    for (Item item : products) {
            %>
            <tr>
                <td><strong>#<%= item.getId() %></strong></td>
                <td><%= item.getName() %></td>
                <td>$<%= String.format("%.2f", item.getPrice()) %></td>
                <td>
                        <span class="badge <%= item.getStockLevel() < 10 ? "bg-danger" : "bg-secondary" %> p-2">
                            <%= item.getStockLevel() %> units
                        </span>
                </td>
                <td>
                    <%= (item instanceof PerishableItem) ? "Perishable" : "Durable" %>
                </td>
                <td>
                    <small class="text-muted">
                        <% if (item instanceof PerishableItem) { %>
                        Expiry: <%= ((PerishableItem) item).getExpiryDate() %>
                        <% } else if (item instanceof DurableItem) { %>
                        Warranty: <%= ((DurableItem) item).getWarrantyPeriod() %>
                        <% } %>
                    </small>
                </td>
                <td class="text-primary fw-bold">
                    $<%= String.format("%.2f", item.calculateStockValue()) %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7" class="text-center text-muted py-4">No products found in the active database.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>