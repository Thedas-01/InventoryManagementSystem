package com.example.inventorymanagementsystem.dao;

import com.example.inventorymanagementsystem.model.Item;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Minimal in-memory ProductDAO in the com.example.inventorymanagementsystem.dao package
 * to satisfy references from servlets during development.
 */
public class ProductDAO {
    private final List<Item> products = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1);

    public ProductDAO() {}

    public boolean addProduct(Item item) {
        if (item == null) return false;
        item.setId(idGenerator.getAndIncrement());
        return products.add(item);
    }

    public boolean updateStock(int id, int newStock) {
        for (Item it : products) {
            if (it.getId() == id) {
                it.setStockLevel(newStock);
                return true;
            }
        }
        return false;
    }

    public List<Item> getAllProducts() {
        return new ArrayList<>(products);
    }
}

