package com.example.inventorymanagementsystem.model;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class PerishableItem extends Item {
    private String expiryDate;

    public PerishableItem(int id, String name, double price, int stockLevel, String expiryDate) {
        super(id, name, price, stockLevel);
        setExpiryDate(expiryDate);
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        if (expiryDate == null || expiryDate.isBlank()) {
            throw new IllegalArgumentException("Expiry date is required.");
        }

        try {
            // Parsing validates the date and stores it consistently as YYYY-MM-DD.
            this.expiryDate = LocalDate.parse(expiryDate.trim()).toString();
        } catch (DateTimeParseException exception) {
            throw new IllegalArgumentException(
                    "Expiry date must be a valid date in YYYY-MM-DD format.", exception);
        }
    }

    @Override
    public double calculateStockValue() {
        return getPrice() * getStockLevel();
    }
}
