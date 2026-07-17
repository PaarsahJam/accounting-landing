# Changelog

All notable changes to this project are documented in this file.
Versions follow [Semantic Versioning](https://semver.org/).

---

## [1.0.0] — 2026-07-17 — Stable Release

### Release Highlights
First production-ready stable release. Full ERP accounting suite with 36 feature
modules, 675 passing tests, dual EN/FA localization, and Material 3 theming.

### Polish & Release Preparation
- Version bumped to `1.0.0+1`
- README completely rewritten with architecture, setup, and feature documentation
- CHANGELOG consolidated with full version history
- Empty `assets/` directory declaration removed from pubspec.yaml
- Bootstrap loading state: `SizedBox.shrink()` replaced with `CircularProgressIndicator.adaptive()`
- Dark theme font corrected from `Inter` to `VazirMatn` for RTL consistency
- `AppTheme` enhanced: `appBarTheme`, `cardTheme`, `inputDecorationTheme`, `listTileTheme` added to both light and dark themes
- Dashboard quick actions: duplicate `account_balance_wallet` icons resolved; all 15 cards wrapped with `Semantics(button: true)`
- `DashboardMetricCard` metric rows wrapped with `Semantics(label: 'label: value')`
- `ActivityTimeline` items wrapped with combined `Semantics` labels; `CircleAvatar` icon marked `excludeSemantics: true`
- `InvoicesPage` raw loading/error replaced with `AppLoadingState` / `AppErrorState`
- Dashboard section headings use `SectionHeader` consistently; `_ProfitStat` adds `Semantics`

---

## [0.37.0] — Dashboard Polish

- Spacing, alignment, and typography consistency across dashboard
- `AppErrorState` rewritten: error icon, `onRetry` callback, better padding
- `AppLoadingState` rewritten: `CircularProgressIndicator.adaptive()`, `liveRegion: true`
- `AppEmptyState` rewritten: configurable icon, optional action CTA, muted colors
- `ResponsivePageScaffold` added `floatingActionButton` and `bottomNavigationBar` params
- `SectionHeader` added `Semantics(header: true)`, muted subtitle color

---

## [0.33.0] — Multi-Currency

- ISO 4217 currency registry (USD, EUR, GBP, AED, IRR)
- Exchange rate management with effective date
- Base currency selection with audit trail
- Edit exchange rate dialog
- `CurrenciesPage` with tabbed Currencies / Exchange Rates views
- Active/inactive and BASE badges
- Settings entry and dashboard quick action
- Router route: `/currencies`
- Tests: 26 (repository × 10, controller × 7, widget × 6, model × 3)

---

## [0.32.0] — User Roles & Permissions

- User management with role assignment
- Permission sets (view, edit, delete, post, close, manage)
- Deactivate user action
- Tests included

---

## [0.31.0] — Import / Export

- CSV export and import for major entity types
- Job history with status and row count
- CSV preview dialog
- Dashboard quick action and Settings entry

---

## [0.30.0] — Fixed Assets

- Fixed asset registry with categories
- Straight-line and declining-balance depreciation
- Depreciation schedule viewer
- Dispose asset action
- Audit trail integration

---

## [0.29.0] — Recurring Transactions

- Recurring transaction templates
- Daily / Weekly / Monthly / Quarterly / Yearly frequencies
- Activate / Deactivate / Execute Now actions
- Audit trail integration

---

## [0.28.0] — Global Search

- Cross-entity full-text search
- Result grouping by entity type
- Recent search history

---

## [0.27.0] — Tags

- Tag management (create, edit, delete)
- Tag assignment to documents
- Color-coded tags

---

## [0.26.0] — Attachments & Comments

- File attachment support on documents
- Rename, edit notes, remove attachment
- Internal comments and notes on documents
- Edit and delete comments

---

## [0.25.0] — Audit Trail

- Immutable audit log for all mutations
- Action taxonomy (Created, Edited, Posted, Locked, Cancelled, …)
- Entity type taxonomy
- Previous/new value tracking
- Filter by action type

---

## [0.24.0] — Approval Workflow

- Document lifecycle: Draft → Pending Approval → Approved → Posted → Locked → Cancelled
- Workflow transition buttons
- Approval timeline view
- Document numbering per entity type

---

## [0.23.0] — Bank Reconciliation

- Bank statement import (mock)
- Auto-match transactions
- Manual match / unmatch
- Reconciliation finalization
- Difference calculation

---

## [0.22.0] — Bank Accounts & Transactions

- Bank account registry (Checking, Savings, Cash, Credit Card)
- Transaction history with running balance
- Bank statements list

---

## [0.21.0] — Fiscal Periods

- Fiscal year management
- Fiscal period open / close
- Year-end closing

---

## [0.20.0] — Financial Dashboard

- KPI cards: AR, AP, Inventory, Cash Position
- Monthly Revenue and Expenses bar charts
- Profit Overview (Revenue, Expenses, Gross Profit, Net Profit)
- Recent Activity timeline
- Quick Actions horizontal scroll
- Responsive: 1 / 2 / 3 column layouts
- Keyboard shortcut: Ctrl+R to refresh

---

## [0.19.0] — Journal Explorer

- General journal with full history
- Search by reference or narration
- Filter by source type, account code, date range
- Sort by newest / oldest
- Drill-down to journal entry detail

---

## [0.18.0] — Journal Preview

- Pre-posting journal preview per document
- Posting lines with debit / credit
- Narration and posting date

---

## [0.17.0] — Vendor Statements

- Vendor statement with opening balance
- Bill history and payment history
- AP aging analysis
- Running balance

---

## [0.16.0] — Customer Statements

- Customer statement with opening balance
- Invoice history and payment history
- AR aging analysis
- Running balance

---

## [0.15.0] — Stock Transfers

- Inter-warehouse stock transfer
- Pending / Completed / Cancelled status
- Insufficient stock validation

---

## [0.14.0] — Inventory Valuation & Stock Ledger

- Average-cost inventory valuation
- Per-product stock ledger with movement history
- Warehouse filter

---

## [0.13.0] — Stock Adjustments

- Positive and negative stock adjustments
- Reason field
- Audit trail

---

## [0.12.0] — Inventory & Warehouses

- Product catalog with SKU, category, unit, price
- Warehouse management
- Stock-on-hand per warehouse

---

## [0.11.0] — Vendor Payments

- Vendor payment recording
- Bill allocation
- Payment detail view

---

## [0.10.0] — Customer Payments

- Customer payment recording
- Invoice allocation
- Payment detail view

---

## [0.9.0] — Sales Invoices

- Sales invoice with line items, tax, subtotal, total
- Status workflow
- Detail page

---

## [0.8.0] — Vendor Bills

- Vendor bill with purchase order linkage
- Goods receipt matching
- Detail page

---

## [0.7.0] — Purchase Orders

- Purchase order management
- Line items with quantity and unit price
- Status workflow

---

## [0.6.0] — General Ledger

- Chart of accounts
- Account detail with transaction history
- Trial balance
- Journal entries

---

## [0.5.0] — Financial Reports

- Trial Balance
- Balance Sheet
- Profit & Loss
- Cash Flow Statement
- AR Aging / AP Aging

---

## [0.4.0] — Customers & Vendors

- Customer directory
- Vendor directory
- Search, add, edit

---

## [0.3.0] — Expenses

- Expense list
- Basic CRUD

---

## [0.2.0] — Invoicing

- Invoice list with grid layout
- Create, edit, delete invoices
- Keyboard shortcut: Ctrl+N

---

## [0.1.0] — Initial Release

- Flutter project scaffold
- Authentication (Login / Signup — mock)
- Dashboard shell
- GoRouter navigation
- Riverpod state management
- EN + FA localization
- Material 3 theme
