package com.example.inventorymanagementsystem.model;

public abstract class Item {
    // Encapsulation: Private fields protect data from unauthorized direct modification
    private int id;
    private String name;
    private double price;
    private int stockLevel;

    // Constructor to initialize a common product
    public Item(int id, String name, double price, int stockLevel) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stockLevel = stockLevel;
    }

    // Encapsulation: Public Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStockLevel() { return stockLevel; }
    public void setStockLevel(int stockLevel) { this.stockLevel = stockLevel; }

    // Polymorphism: Abstract method to be overridden by specialized subclasses
    public abstract double calculateStockValue();
}

