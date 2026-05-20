package com.example.inventorymanagementsystem.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Port 3306 based on your earlier MySQL connection status screen
    private static final String URL = "jdbc:mysql://localhost:3306/inventory_db";
    private static final String USER = "root";
    private static final String PASSWORD = "password";
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(DRIVER_CLASS);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connection Successful!");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check your password or if MySQL server is running.");
            e.printStackTrace();
        }
        return connection;
    }
}

