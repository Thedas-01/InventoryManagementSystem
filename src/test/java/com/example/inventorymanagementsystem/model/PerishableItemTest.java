package com.example.inventorymanagementsystem.model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class PerishableItemTest {

    @Test
    void storesAValidExpiryDateInIsoFormat() {
        PerishableItem item = new PerishableItem(1, "Milk", 250.0, 4, " 2026-08-31 ");

        assertEquals("2026-08-31", item.getExpiryDate());
    }

    @Test
    void rejectsAnImpossibleExpiryDate() {
        assertThrows(IllegalArgumentException.class,
                () -> new PerishableItem(1, "Milk", 250.0, 4, "2026-02-30"));
    }

    @Test
    void rejectsAMissingExpiryDate() {
        assertThrows(IllegalArgumentException.class,
                () -> new PerishableItem(1, "Milk", 250.0, 4, " "));
    }

    @Test
    void calculatesStockValue() {
        PerishableItem item = new PerishableItem(1, "Milk", 250.0, 4, "2026-08-31");

        assertEquals(1000.0, item.calculateStockValue());
    }
}
