# Generated app architecture

This explains how a **Flutter Forge** project fits together — from app launch to a single screen update.

## High-level flow

```mermaid
flowchart TD
    main[main.dart] --> dotenv[Load .env + AppConfig]
    dotenv --> db[Open SQLite]
    db --> repo[SettingsRepository]
    repo --> runApp[runApp ForgeApp]
    runApp --> app[app.dart GetMaterialApp]
    app --> splash[/splash SplashView]
    splash -->|first launch| onboarding[/onboarding]
    splash -->|returning user| shell[/shell MainShellView]
    onboarding --> shell
    shell --> home[Home tab]
    shell --> explore[Explore tab]
    shell --> settings[Settings tab]
```

## Entry point: `lib/main.dart`

1. `WidgetsFlutterBinding.ensureInitialized()`
2. `dotenv.load` — reads `.env` from assets
3. `AppConfig.validate()` — warns in debug if keys are missing
4. `DatabaseHelper.instance.database` — opens SQLite
5. `Get.put(SettingsRepository())` — global settings (theme, onboarding flag)
6. `runApp(const ForgeApp())`

**Edit here when:** you need global init (e.g. crash reporting, other SDKs) — keep secrets in `.env`, not in code.

---

## App shell: `lib/app.dart`

`ForgeApp` builds `GetMaterialApp` with:

| Property | Source |
|----------|--------|
| `theme` / `darkTheme` | `AppTheme` in `lib/core/theme/` |
| `themeMode` | `SettingsRepository.themeMode` (reactive `Obx`) |
| `initialRoute` | `AppRoutes.splash` |
| `getPages` | `AppPages.pages` |
| `initialBinding` | `InitialBindings()` — global services |

**Edit here when:** changing app title, default transition, or global `GetMaterialApp` behavior.

---

## Routing

| File | Role |
|------|------|
| `lib/routes/app_routes.dart` | String constants (`/splash`, `/home`, …) |
| `lib/routes/app_pages.dart` | `GetPage` list: route → view + optional `binding` |

Navigation in controllers:

```dart
AppHelper.offAllNamed(AppRoutes.shell);
AppHelper.toNamed(AppRoutes.explore);
```

**Edit here when:** adding a new screen — or run `npx flutter-forge feature <name>`.

---

## Dependency injection (GetX)

### Global: `lib/bindings/initial_bindings.dart`

Registers once at app start:

- `AppLogger`
- `DatabaseHelper`
- `SettingsRepository` (if not already from `main`)
- `NetworkManager`

### Per-route: `features/*/bindings/*_binding.dart`

Example: `SplashBinding` → `Get.lazyPut(SplashController.new)`.

`MainShellBinding` also registers tab controllers (`Home`, `Explore`, `Settings`) because tabs use `IndexedStack` without separate route navigation.

**Edit here when:** a service should live for the whole app → `InitialBindings`; for one flow → feature binding.

---

## Feature module anatomy

Each feature under `lib/features/<name>/`:

```
feature_name/
├── bindings/     # Get.put / lazyPut for this feature
├── controllers/  # GetxController — logic, .obs state
├── views/        # UI — extends GetView<Controller>
├── models/       # optional data classes
└── widgets/      # feature-private widgets
```

**Data flow:** View → Controller → Repository → DAO → SQLite

---

## Splash → Onboarding → Shell (detailed)

### 1. Splash (`features/splash/`)

- **View:** Shows app name + welcome message (`AppTexts.welcomeMessage`)
- **Controller:** Waits ~2s (or tap), reads `SettingsRepository.hasSeenOnboarding()`
- **Next:** `AppRoutes.onboarding` or `AppRoutes.shell`

**Customize:** `splash_view.dart` (UI), `app_texts.dart` (copy), `splash_controller.dart` (timing/logic)

### 2. Onboarding (`features/onboarding/`)

- **View:** `PageView` with skip / get started
- **Controller:** On finish → `setOnboardingComplete()` in SQLite → `offAllNamed(shell)`

**Customize:** Add pages in `onboarding_controller.dart` `pages` list

### 3. Shell (`features/shell/`)

- **View:** `NavigationBar` + `IndexedStack` (Home, Explore, Settings)
- **Controller:** `selectedIndex.obs` for tab index

**Customize:** Add a tab → new feature + widget in `pages` list + `MainShellBinding`

---

## Core layer (`lib/core/`)

| Folder | Purpose |
|--------|---------|
| `config/` | `AppConfig` — API URL, keys from `.env` |
| `constants/` | Colors, sizes, strings, images |
| `theme/` | `AppTheme` + `custom_themes/` |
| `utils/validators` | Form validation |
| `utils/formatters` | Date, currency, phone |
| `utils/helpers` | Navigation wrappers, snackbars |
| `utils/logging` | `AppLogger` |
| `utils/device` | Platform / device info |
| `exceptions/` | Typed errors + `ExceptionHandler` |
| `popups/` | Dialogs, snackbars, loading |
| `network/` | Connectivity checks |

Shared across all features — avoid duplicating this logic in controllers.

---

## Data layer (`lib/data/`)

| Piece | Role |
|-------|------|
| `database_helper.dart` | SQLite singleton, version, `onCreate` / `onUpgrade` |
| `tables.dart` | Table name constants |
| `daos/` | Raw SQL / queries |
| `repositories/` | App-facing API (controllers use these, not DAOs) |

**Settings** stored in `app_settings` key/value table (onboarding flag, theme mode).

**Optional notes table** (if enabled at create time) — demo list on Explore.

---

## Common UI (`lib/common/`)

| Folder | Purpose |
|--------|---------|
| `layouts/` | `PageWrapper`, `ResponsiveLayout`, `GridLayout` |
| `widgets/` | Buttons, loaders, empty state, section header, search bar |

Use for UI repeated across features; keep feature-specific widgets inside the feature folder.

---

## Environment & secrets

| File | Committed? | Purpose |
|------|------------|---------|
| `.env.example` | Yes | Template for teammates |
| `.env` | **No** (gitignored) | Real keys locally |
| `app_config.dart` | Yes | Reads env at runtime |

Production: use `--dart-define`, CI secrets, or platform-specific config — not committed `.env`.
