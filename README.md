# Accounting App

A production-ready, cross-platform accounting and business management application built with Flutter.

The application is designed with a modular, scalable architecture and includes accounting, banking, inventory, purchasing, sales, reporting, localization, and administrative features. It targets desktop, web, and mobile platforms using a single Flutter codebase.

---

## Developer

**Paarsah Soroury Jam**

GitHub: https://github.com/PaarsahJam

---

## Development Assistance

This project was developed with the assistance of AI tools for:

- Software architecture review
- Code generation and refactoring
- Debugging and issue resolution
- Test generation
- Documentation and release preparation

All architectural decisions, feature selection, project direction, and final review were performed by the project developer.

---

# Features

### Accounting

- Double-entry bookkeeping
- Journal Entries
- Chart of Accounts
- General Ledger
- Trial Balance
- Fiscal Years & Periods

### Sales

- Customers
- Quotations
- Sales Orders
- Delivery Notes
- Sales Invoices
- Customer Payments
- Credit Notes

### Purchasing

- Vendors
- Purchase Orders
- Goods Receipts
- Vendor Bills
- Vendor Payments

### Banking

- Bank Accounts
- Bank Transactions
- Bank Reconciliation

### Inventory

- Products
- Warehouses
- Stock Ledger
- Inventory Valuation
- Stock Adjustments
- Stock Transfers

### Financial Management

- Budgeting
- Financial Reports
- Dashboard Metrics
- Recurring Transactions
- Fixed Assets & Depreciation
- Multi-Currency

### Productivity

- Global Search
- Tags & Labels
- Comments & Internal Notes
- Document Attachments
- Import / Export (CSV)

### Administration

- User Roles & Permissions
- Audit Trail
- Localization (English & Persian)
- Responsive UI
- RTL Support

---

# Technology Stack

- Flutter
- Dart
- Riverpod
- Riverpod Generator
- GoRouter
- Material Design 3
- Intl Localization
- Flutter Localizations

---

# Architecture

The application follows a clean feature-based architecture.

```
lib/
 ├── app/
 ├── core/
 ├── features/
 │     ├── accounting/
 │     ├── banking/
 │     ├── inventory/
 │     ├── reporting/
 │     ├── ...
 └── l10n/
```

Each feature follows the same structure:

```
feature/
 ├── data/
 ├── domain/
 └── presentation/
```

State management is implemented using Riverpod with generated providers.

Repositories are abstracted behind interfaces with mock implementations to allow testing without external services.

---

# Getting Started

## Requirements

- Flutter Stable
- Dart SDK
- Git

## Clone the repository

```bash
git clone https://github.com/PaarsahJam/accounting-app.git
```

## Install packages

```bash
flutter pub get
```

## Generate code

```bash
dart run build_runner build
```

## Generate localization

```bash
flutter gen-l10n
```

## Run the application

```bash
flutter run
```

---

# Testing

Run all tests:

```bash
flutter test
```

Analyze the project:

```bash
flutter analyze
```

---

# Localization

The application currently supports:

- 🇺🇸 English
- 🇮🇷 Persian (RTL)

Localization is powered by Flutter's internationalization system using ARB files.

---

# Project Status

**Version:** **v1.0.0**

Current status:

- Production-ready architecture
- 37 implemented feature modules
- 675 automated tests passing
- Responsive desktop and mobile layouts
- Full RTL support
- Mock repositories for demonstration and development

---

# Roadmap

## Version 1.0

- ✅ Core accounting
- ✅ Sales
- ✅ Purchasing
- ✅ Inventory
- ✅ Banking
- ✅ Financial Reporting
- ✅ User Permissions
- ✅ Multi-Currency
- ✅ Fixed Assets
- ✅ Recurring Transactions
- ✅ Import / Export
- ✅ Dashboard
- ✅ Global Search

## Planned for Version 2

Potential future enhancements include:

- CRM
- Workflow Engine
- REST API
- Multi-company support
- Notifications
- Backup & Restore
- Offline Synchronization
- Plugin Architecture
- AI-powered assistants

---

# Contributing

This project is currently maintained by the developer and is not accepting external contributions at this time.

---

# License

Copyright © 2026 **Paarsah Soroury Jam**

All rights reserved.

This software and its source code are the intellectual property of the copyright holder.

No part of this software may be copied, modified, distributed, published, or used for commercial purposes without prior written permission from the copyright holder.