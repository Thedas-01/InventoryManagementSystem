package com.example.inventorymanagementsystem.model;

public class DurableItem extends Item {
    // Unique attribute for durable products
    private String warrantyPeriod;

    // Constructor using 'super'
    public DurableItem(int id, String name, double price, int stockLevel, String warrantyPeriod) {
        super(id, name, price, stockLevel);
        this.warrantyPeriod = warrantyPeriod;
    }

    // Getter and Setter
    public String getWarrantyPeriod() { return warrantyPeriod; }
    public void setWarrantyPeriod(String warrantyPeriod) { this.warrantyPeriod = warrantyPeriod; }

    // Overriding the abstract method differently (Polymorphism)
    @Override
    public double calculateStockValue() {
        // Durable goods have an adjusted logistics asset value overhead calculated into total stock value
        return (getPrice() * getStockLevel()) * 1.05;
    }
}

