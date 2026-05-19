<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.example.inventorymanagementsystem.model.Item" %>
<%@ page import="com.example.inventorymanagementsystem.model.PerishableItem" %>
<%@ page import="com.example.inventorymanagementsystem.model.DurableItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Current Inventory Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Black & White theme for inventory page */
        body { background: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #111; }

        .inventory-base {
            min-height: 100vh;
            padding-top: 3.5rem;
            padding-bottom: 3.5rem;
            background: linear-gradient(180deg, #f5f5f5 0%, #fafafa 100%);
        }

        .inventory-card {
            background: #ffffff;
            border-radius: 14px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.08);
            border: 1px solid #dcdcdc;
        }

        /* Dark table header */
        .table thead th {
            background: #111 !important;
            color: #fff !important;
            border-color: #000 !important;
        }

        /* Rows and text */
        .table tbody td { vertical-align: middle; }

        /* Badges: low stock red, normal dark gray */
        .badge-bg-low { background: #b30000; color: #fff; }
        .badge-bg-normal { background: #6c757d; color: #fff; }

        /* Back button uses dark outline */
        .btn-inv-back { border: 1px solid #111; color: #111; background: transparent; }
        .btn-inv-back:hover { background: #111; color: #fff; }

        /* Responsive tweaks */
        @media (max-width: 768px) {
            .inventory-base { padding-top: 2rem; padding-bottom: 2rem; }
        }
    </style>
</head>
<body>
<div class="inventory-base">
    <div class="container mt-2">
    <div class="card inventory-card shadow-sm p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-dark">Current Stock Inventory</h2>
            <a href="index.jsp" class="btn btn-inv-back">Back to Management Panel</a>
        </div>

        <% DecimalFormat df = new DecimalFormat("#,##0.00"); %>
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
                <td>Rs.<%= df.format(item.getPrice()) %></td>
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
                    Rs.<%= df.format(item.calculateStockValue()) %>
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
</div>
</body>
</html>