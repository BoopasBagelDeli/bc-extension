# Bakery Business Central Project Structure

## Overview
This folder structure organizes all aspects of the bakery Business Central implementation following AL development best practices.

## Source Code Organization (`/src/`)

### BakeryCore
Foundation objects and master data extensions
- **Object Range**: 50000-50099
- **Purpose**: Core business logic, setup tables, and base functionality

### BakeryInventory  
Inventory management with food-specific requirements
- **Object Range**: 50100-50199
- **Purpose**: FIFO tracking, expiration management, storage categories

### BakeryProduction
Recipe management and production workflows
- **Object Range**: 50200-50299
- **Purpose**: BOMs, production orders, yield tracking

### BakerySales
Multi-channel sales management
- **Object Range**: 50300-50399
- **Purpose**: Retail, wholesale, catering, delivery platform sales

### BakeryIntegrations
External system connections
- **Object Range**: 50400-50499
- **Purpose**: Toast POS, delivery platforms, nutritional APIs

### BakeryCompliance
Food safety and regulatory compliance
- **Object Range**: 50500-50599
- **Purpose**: Traceability, allergen tracking, certifications

### BakeryReporting
Analytics and business intelligence
- **Object Range**: 50600-50699
- **Purpose**: Dashboards, KPIs, custom reports

## Data Collection (`/data/`)

### Requirements
Business and technical specifications

### Reference Data
Master data for import organized by entity type

### Mapping
Integration configuration and field mappings

### Templates
Data collection spreadsheets and forms

## Implementation Guidelines

1. **Use consistent naming**: All objects prefixed with "BKY"
2. **Maintain object ranges**: Stick to allocated number ranges
3. **Document everything**: Each object should have clear purpose
4. **Follow dependencies**: Core → Inventory → Production → Sales → Integrations
5. **Test incrementally**: Build and test each module independently

## Next Steps

1. Start with BakeryCore foundation objects
2. Define master data extensions (Items, Customers, Vendors)
3. Build inventory management functionality
4. Implement production and recipe management
5. Add sales channel management
6. Configure integrations
7. Set up reporting and analytics

---
*Created: June 18, 2025*
