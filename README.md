# Accounting App — v1.0.0

A production-ready, cross-platform accounting application built with Flutter.
Supports Android, iOS, Web, Windows, macOS, and Linux from a single codebase.

---

## Features

| Module | Description |
|---|---|
| **Dashboard** | Financial KPIs, charts, profit overview, recent activity, quick actions |
| **Invoicing** | Create, edit, and delete invoices with status tracking |
| **Sales Invoices** | Full sales invoice lifecycle with line items, tax, and approval workflow |
| **Vendor Bills** | Vendor bill management with purchase-order linkage and goods-receipt matching |
| **Customer Payments** | Record customer receipts with invoice allocation |
| **Vendor Payments** | Record vendor disbursements with bill allocation |
| **Customer Statements** | AR statements, invoice history, aging analysis |
| **Vendor Statements** | AP statements, bill history, aging analysis |
| **Purchase Orders** | Purchase order management with status workflow |
| **General Ledger** | Chart of accounts, journal entries, trial balance |
| **Journal Explorer** | Full general journal with search, filters, and drill-down |
| **Journal Preview** | Document-level journal preview before posting |
| **Financial Reports** | Trial balance, balance sheet, P&L, cash flow, AR/AP aging |
| **Bank Accounts** | Bank account registry with transaction history |
| **Bank Statements** | Import and manage bank statements |
| **Bank Reconciliation** | Auto-match and manual reconciliation with finalization |
| **Inventory** | Products, warehouses, stock-on-hand management |
| **Stock Ledger** | Per-product movement history |
| **Stock Adjustments** | Positive and negative stock adjustments |
| **Inventory Valuation** | Average-cost valuation across warehouses |
| **Stock Transfers** | Inter-warehouse stock transfers |
| **Fixed Assets** | Asset registry, straight-line and declining-balance depreciation |
| **Recurring Transactions** | Scheduled transaction templates with frequency settings |
| **Multi-Currency** | ISO 4217 currency management, exchange rates, base-currency selection |
| **Customers** | Customer directory with balance tracking |
| **Vendors** | Vendor directory with contact and tax data |
| **Tags** | Document tagging system |
| **Attachments** | File attachment support on documents |
| **Comments** | Internal notes and comments on documents |
| **Audit Trail** | Immutable audit log for every state change |
| **Document Numbering** | Sequential document numbering per entity type |
| **Approval Workflow** | Document lifecycle: Draft → Pending → Approved → Posted → Locked |
| **Fiscal Periods** | Fiscal year and period management with open/close operations |
| **User Roles** | User management with role-based permission sets |
| **Global Search** | Cross-entity full-text search |
| **Import / Export** | CSV import and export for major entity types |
| **Settings** | Application settings and navigation hub |

---

## Tech Stack

| Concern | Library |
|---|---|
| Framework | Flutter 3.44.4 / Dart 3.12.2 |
| State management | Riverpod (riverpod_annotation + riverpod_generator) |
| Navigation | go_router |
| Localization | flutter_localizations + intl (EN + FA/RTL) |
| Fonts | google_fonts (VazirMatn — supports Persian/RTL) |
| HTTP client | dio |
| Storage | flutter_secure_storage, flutter_dotenv |
| Code generation | build_runner, freezed, json_serializable |
| Testing | flutter_test |

---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.44 (`flutter --version`)
- Dart SDK ≥ 3.12

### Install

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
```

### Run

```bash
flutter run -d chrome          # web
flutter run -d windows         # desktop
flutter run                    # connected device
```

### Test

```bash
flutter test
```

### Analyze

```bash
flutter analyze
dart format .
```

---

## Project Structure

```
lib/
├── app/                    # App bootstrap, MaterialApp wiring
├── core/
│   ├── errors/             # AppResult, AppFailure
│   ├── finance/            # Finance engine (immutable, no side effects)
│   ├── logging/            # AppLogger
│   ├── router/             # GoRouter configuration (35+ routes)
│   └── theme/              # AppTheme (light + dark, Material 3)
├── features/               # 36 feature modules
│   └── <feature>/
│       ├── data/           # Repository + Riverpod provider
│       ├── domain/         # Models, controllers (.dart + .g.dart)
│       └── presentation/   # Pages and feature widgets
├── l10n/                   # ARB files + generated localization
│   ├── app_en.arb          # English strings (763 keys)
│   ├── app_fa.arb          # Farsi/Persian strings (763 keys)
│   └── app_localizations*.dart
├── modules/                # Cross-cutting modules
└── shared/
    └── widgets/            # AppLoadingState, AppErrorState, AppEmptyState,
                            # ResponsivePageScaffold, SectionHeader, …
```

---

## Architecture

The application follows a **feature-first, clean-layered** architecture:

```
Page → Controller (Riverpod AsyncNotifier) → Repository → Domain Model
                                           → AppResult<T>
```

- **Domain models** are plain Dart classes with `copyWith`, `==`, `hashCode`.
- **Repositories** expose typed async operations returning `AppResult<T>`.
- **Controllers** are Riverpod `@riverpod` async notifiers that load, mutate, and invalidate state.
- **Pages** consume providers with `.when(loading, error, data)`.
- All implementations are **mock-only** — no network calls in v1.0.
- **Audit Trail** entries are created by repositories for every significant mutation.

See [`docs/architecture.md`](docs/architecture.md) for the full architecture guide.

---

## Localization

The app defaults to **Farsi (RTL)** and also supports English.

To add a string: edit both `lib/l10n/app_en.arb` and `lib/l10n/app_fa.arb`,
then run `flutter gen-l10n`.

---

## Screenshots

> Screenshots will be added after first device build.

---

## Known Limitations (v1.0)

- All data is mock in-memory — no persistence between sessions.
- No real authentication — login accepts any credentials.
- No network calls — all repositories use `MockXxx` implementations.
- No push notifications.
- No PDF generation.
- No real file I/O for import/export — CSV is simulated.

---

## License

Private — all rights reserved.
