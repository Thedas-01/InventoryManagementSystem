<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f5f5;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .header-gradient {
            background: #1a1a1a;
            color: white;
            padding: 3rem 0;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 3rem;
            border-bottom: 3px solid #000;
        }

        .header-gradient h1 {
            font-weight: 700;
            font-size: 2.5rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
            margin-bottom: 0.5rem;
        }

        .header-gradient p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 0;
            color: #e0e0e0;
        }

        .view-inventory-btn {
            background: #000;
            border: 2px solid white;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            color: white;
        }

        .view-inventory-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
            background: #333;
            color: white;
        }

        .card {
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
            overflow: hidden;
            background: white;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
            border-color: #000;
        }

        .card-header-gradient {
            background: #2a2a2a;
            color: white;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0 !important;
            border-bottom: 2px solid #000;
        }

        .card-header-gradient-add {
            background: #1a1a1a;
        }

        .card-header-gradient-update {
            background: #333333;
        }

        .card-body {
            padding: 2rem;
            background: white;
        }

        .card h4 {
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            color: white;
        }

        .form-label {
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 0.6rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-control, .form-select {
            border: 2px solid #ddd;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafafa;
            color: #333;
        }

        .form-control:focus, .form-select:focus {
            border-color: #000;
            box-shadow: 0 0 0 0.2rem rgba(0, 0, 0, 0.1);
            background: white;
        }

        .form-control::placeholder {
            color: #999;
            font-style: italic;
        }

        .btn-submit {
            font-weight: 600;
            padding: 0.9rem 1.5rem;
            border-radius: 10px;
            border: none;
            transition: all 0.3s ease;
            font-size: 1.1rem;
            position: relative;
            overflow: hidden;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.15);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-add {
            background: #1a1a1a;
            color: white;
            border: 1px solid #333;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            color: white;
            background: #000;
        }

        .btn-update {
            background: #444;
            color: white;
            border: 1px solid #555;
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            color: white;
            background: #222;
        }

        .form-icon {
            display: inline-block;
            color: #1a1a1a;
            font-size: 1rem;
        }

        .container {
            max-width: 1200px;
        }

        .row.g-4 {
            padding: 0 1rem;
        }

        @media (max-width: 768px) {
            .header-gradient h1 {
                font-size: 2rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .row.g-4 > div {
                margin-bottom: 1.5rem;
            }
        }

        .icon-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.15);
            color: white;
            font-size: 1.3rem;
            margin-right: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .card-header-gradient .icon-badge {
            background: rgba(255, 255, 255, 0.15);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header-gradient">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap">
                <div>
                    <h1><i class="bi bi-box2-heart"></i> Inventory Hub</h1>
                    <p>Professional Stock Management & Control Dashboard</p>
                </div>
                <a href="product?action=list" class="btn view-inventory-btn mt-3 mt-md-0">
                    <i class="bi bi-list-check"></i> View Inventory List
                </a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row g-4 pb-5">
            <!-- Add Product Card -->
            <div class="col-lg-7">
                <div class="card">
                    <div class="card-header-gradient card-header-gradient-add">
                        <h4>
                            <span class="icon-badge"><i class="bi bi-plus-circle-fill"></i></span>
                            Add New Product
                        </h4>
                    </div>
                    <div class="card-body">
                        <form id="addProductForm" action="product" method="POST" onsubmit="return validateAddForm(event)">
                            <input type="hidden" name="action" value="add">
                            <!-- validation feedback placeholder -->
                            <div id="addFormAlert"></div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-tag form-icon"></i> Product Name
                                </label>
                                <input type="text" name="name" class="form-control" placeholder="Enter product name" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-currency-dollar form-icon"></i> Price
                                    </label>
                                    <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        <i class="bi bi-box form-icon"></i> Initial Stock
                                    </label>
                                    <input type="number" name="stock" class="form-control" placeholder="0" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-diagram-3 form-icon"></i> Item Classification
                                </label>
                                <select name="itemType" id="itemType" class="form-select" onchange="toggleAttributeField()">
                                    <option value="PERISHABLE">Perishable (Requires Expiry Date)</option>
                                    <option value="DURABLE">Durable (Requires Warranty)</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label id="attrLabel" class="form-label">
                                    <i class="bi bi-calendar form-icon"></i> Expiry Date
                                </label>
                                <input type="text" name="specialAttribute" id="specialAttribute" class="form-control" placeholder="YYYY-MM-DD" required>
                            </div>

                            <button type="submit" class="btn btn-submit btn-add w-100">
                                <i class="bi bi-save"></i> Save Product
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Update Stock Card -->
            <div class="col-lg-5">
                <div class="card">
                    <div class="card-header-gradient card-header-gradient-update">
                        <h4>
                            <span class="icon-badge"><i class="bi bi-arrow-repeat"></i></span>
                            Quick Stock Adjustment
                        </h4>
                    </div>
                    <div class="card-body">
                        <form id="updateStockForm" action="product" method="POST" onsubmit="return validateUpdateForm(event)">
                            <input type="hidden" name="action" value="updateStock">
                            <div id="updateFormAlert"></div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-key form-icon"></i> Product ID
                                </label>
                                <input type="number" name="id" class="form-control" placeholder="Enter product ID (e.g., 1)" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-graph-up form-icon"></i> New Quantity
                                </label>
                                <input type="number" name="stockLevel" class="form-control" placeholder="Enter new stock level" required>
                            </div>

                            <button type="submit" class="btn btn-submit btn-update w-100">
                                <i class="bi bi-pencil-square"></i> Update Stock
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleAttributeField() {
            var type = document.getElementById("itemType").value;
            var label = document.getElementById("attrLabel");
            var input = document.getElementById("specialAttribute");

            if (type === "PERISHABLE") {
                label.innerHTML = '<i class="bi bi-calendar form-icon"></i> Expiry Date';
                input.placeholder = "YYYY-MM-DD";
            } else {
                label.innerHTML = '<i class="bi bi-shield-check form-icon"></i> Warranty Period';
                input.placeholder = "e.g., 24 Months";
            }
        }

        // ------- Validation Helpers -------
        function showAlert(containerId, message, type) {
            var container = document.getElementById(containerId);
            container.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' +
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                '</div>';
        }

        function isValidDateYMD(str) {
            // expects YYYY-MM-DD
            var m = str.match(/^(\d{4})-(\d{2})-(\d{2})$/);
            if (!m) return false;
            var y = parseInt(m[1], 10), mm = parseInt(m[2], 10) - 1, d = parseInt(m[3], 10);
            var dt = new Date(y, mm, d);
            return dt && dt.getFullYear() === y && dt.getMonth() === mm && dt.getDate() === d;
        }

        function isValidWarranty(str) {
            if (!str) return false;
            // Accept formats: "24 Months", "2 Years", "24M", "36mo", "1 year"
            var m = str.trim().toLowerCase().match(/^(\d+)\s*(months?|mos?|m|years?|yrs?|y)$/i);
            if (m) {
                var n = parseInt(m[1], 10);
                return n > 0;
            }
            // also allow patterns like '24M' or '36mo'
            var m2 = str.trim().toLowerCase().match(/^(\d+)(m|mo|y)$/);
            if (m2) return parseInt(m2[1], 10) > 0;
            return false;
        }

        function validateAddForm(e) {
            var form = document.getElementById('addProductForm');
            var name = form.name.value.trim();
            var price = form.price.value.trim();
            var stock = form.stock.value.trim();
            var type = form.itemType.value;
            var attr = form.specialAttribute.value.trim();

            // basic checks
            if (!name) {
                showAlert('addFormAlert', 'Please enter a product name.', 'warning');
                return false;
            }

            var priceNum = Number(price);
            if (isNaN(priceNum) || priceNum < 0) {
                showAlert('addFormAlert', 'Please enter a valid non-negative price.', 'warning');
                return false;
            }

            var stockNum = Number(stock);
            if (!Number.isInteger(stockNum) || stockNum < 0) {
                showAlert('addFormAlert', 'Please enter a valid non-negative integer for stock.', 'warning');
                return false;
            }

            if (type === 'PERISHABLE') {
                if (!isValidDateYMD(attr)) {
                    showAlert('addFormAlert', 'Please provide a valid expiry date in YYYY-MM-DD format.', 'warning');
                    return false;
                }
            } else if (type === 'DURABLE') {
                if (!isValidWarranty(attr)) {
                    showAlert('addFormAlert', 'Please provide a valid warranty period (e.g., "24 Months" or "2 Years").', 'warning');
                    return false;
                }
            }

            // all good
            return true;
        }

        function validateUpdateForm(e) {
            var form = document.getElementById('updateStockForm');
            var id = form.id.value.trim();
            var stock = form.stockLevel.value.trim();

            var idNum = Number(id);
            if (!Number.isInteger(idNum) || idNum <= 0) {
                showAlert('updateFormAlert', 'Please provide a valid product ID (positive integer).', 'warning');
                return false;
            }

            var stockNum = Number(stock);
            if (!Number.isInteger(stockNum) || stockNum < 0) {
                showAlert('updateFormAlert', 'Please enter a valid non-negative integer for the new stock level.', 'warning');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>