# Architecture Overview

## Feature-first architecture

The application is organized by feature, with each feature owning its own domain, data, and presentation concerns. This keeps business capabilities isolated and easier to evolve independently.

## Recommended folder structure

Each feature should follow this shape:

- `data/` for repository implementations and provider wiring
- `domain/` for controllers, models, and state objects
- `presentation/` for screens and feature-specific widgets

This keeps UI, state, and persistence responsibilities separated while preserving a clear path for future backend integration.

## Repository pattern

Repositories provide the data boundary for each feature. They expose typed operations and return shared result wrappers so the UI and state layer can handle success and failure consistently.

### Flow

1. A page or widget reads a Riverpod provider.
2. The provider resolves a controller or repository dependency.
3. The repository returns an `AppResult` value.
4. The controller transforms the result into an async state for the UI.

## Riverpod conventions

Riverpod providers and generated controllers are the default state-management approach. Controllers are responsible for loading and mutating state, while pages consume providers and render the state.

### Guidelines

- Keep provider logic simple and composable.
- Prefer controller-level orchestration for mutation flows.
- Avoid embedding business logic directly in pages.
- Use `ref.watch` for reads and `ref.read` only when an action needs to trigger state immediately.

## Freezed conventions

Immutable domain models should prefer Freezed for value-based objects. This helps keep domain state predictable and makes the app easier to reason about as it grows.

## Localization conventions

All user-facing strings should be added to the localization bundle and consumed through the generated localization APIs. Hardcoded strings should be avoided in UI code.

## Shared widget conventions

Shared widgets should live under the shared widget layer and be reusable across features. They are intended to capture recurring UI patterns such as loading, empty, error, and scaffold states.

## Coding conventions

- Keep files focused on a single responsibility.
- Favor small, composable widgets over large screen-level components.
- Preserve existing behavior while improving structure.
- Add tests for new shared infrastructure and feature behavior.
- Use the core error/result abstractions for repository and controller flows.

## Naming conventions

- Features use lowercase folder names and clear domain names.
- Repositories end with `Repository`.
- Controllers and providers follow the generated Riverpod naming convention.
- Domain models use descriptive names and should stay immutable.
