package com.example.inventorymanagementsystem.model;

public class PerishableItem extends Item {
    // Unique attribute for perishable products
    private String expiryDate;

    // Constructor using 'super' to pass shared values to the parent Item class
    public PerishableItem(int id, String name, double price, int stockLevel, String expiryDate) {
        super(id, name, price, stockLevel);
        this.expiryDate = expiryDate;
    }

    // Getter and Setter
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    // Overriding the abstract method (Polymorphism)
    @Override
    public double calculateStockValue() {
        // Standard valuation for perishables
        return getPrice() * getStockLevel();
    }
}

