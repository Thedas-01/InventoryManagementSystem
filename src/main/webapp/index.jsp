<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary">Stock Control Dashboard</h2>
        <a href="product?action=list" class="btn btn-success">View Inventory List</a>
    </div>

    <div class="row g-4">
        <div class="col-md-7">
            <div class="card shadow-sm p-4">
                <h4 class="mb-3 text-secondary">Add New Product</h4>
                <form action="product" method="POST">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-3">
                        <label class="form-label">Product Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="col mb-3">
                            <label class="form-label">Price ($)</label>
                            <input type="number" step="0.01" name="price" class="form-control" required>
                        </div>
                        <div class="col mb-3">
                            <label class="form-label">Initial Stock</label>
                            <input type="number" name="stock" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Item Classification</label>
                        <select name="itemType" id="itemType" class="form-select" onchange="toggleAttributeField()">
                            <option value="PERISHABLE">Perishable (Requires Expiry)</option>
                            <option value="DURABLE">Durable (Requires Warranty)</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label id="attrLabel" class="form-label">Expiry Date</label>
                        <input type="text" name="specialAttribute" id="specialAttribute" class="form-control" placeholder="YYYY-MM-DD" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Save Product</button>
                </form>
            </div>
        </div>

        <div class="col-md-5">
            <div class="card shadow-sm p-4">
                <h4 class="mb-3 text-secondary">Quick Stock Adjustment</h4>
                <form action="product" method="POST">
                    <input type="hidden" name="action" value="updateStock">
                    <div class="mb-3">
                        <label class="form-label">Product Database ID</label>
                        <input type="number" name="id" class="form-control" placeholder="e.g. 1" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">New Stock Quantity</label>
                        <input type="number" name="stockLevel" class="form-control" placeholder="e.g. 50" required>
                    </div>
                    <button type="submit" class="btn btn-warning w-100">Update Stock Level</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleAttributeField() {
        var type = document.getElementById("itemType").value;
        var label = document.getElementById("attrLabel");
        var input = document.getElementById("specialAttribute");

        if (type === "PERISHABLE") {
            label.innerText = "Expiry Date";
            input.placeholder = "YYYY-MM-DD";
        } else {
            label.innerText = "Warranty Period";
            input.placeholder = "e.g. 24 Months";
        }
    }
</script>
</body>
</html>