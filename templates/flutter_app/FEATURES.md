# <%= projectName %> — Project guide

Forged with **Flutter Forge**. Use this as your map from first launch to production.

---

## App launch flow

```
main.dart
  → load .env (AppConfig)
  → open SQLite (DatabaseHelper)
  → register SettingsRepository
  → ForgeApp (GetMaterialApp)
      → /splash     Welcome + redirect
      → /onboarding First-time slides (SQLite flag)
      → /shell      Bottom nav: Home | Explore | Settings
```

| Step | File(s) | What to edit |
|------|---------|--------------|
| Startup logic | `lib/main.dart` | Extra SDK init (analytics, etc.) |
| App wrapper | `lib/app.dart` | Title, transitions, theme mode |
| Splash UI | `features/splash/views/splash_view.dart` | Logo, layout, animation |
| Splash timing | `features/splash/controllers/splash_controller.dart` | Delay, redirect rules |
| Welcome text | `core/constants/app_texts.dart` | `welcomeMessage`, `appName` |
| Onboarding | `features/onboarding/` | Slides in controller `pages` list |
| Tabs | `features/shell/views/main_shell_view.dart` | Add/remove tabs |

---

## Routes

| Constant | Path | Screen |
|----------|------|--------|
| `AppRoutes.splash` | `/splash` | Splash |
| `AppRoutes.onboarding` | `/onboarding` | Onboarding |
| `AppRoutes.shell` | `/shell` | Main shell (tabs) |
| `AppRoutes.home` | `/home` | Home (also tab 0) |
| `AppRoutes.explore` | `/explore` | Explore (tab 1) |
| `AppRoutes.settings` | `/settings` | Settings (tab 2) |

**Navigate in code:**

```dart
import 'package:<%= packageName %>/core/utils/helpers/app_helper.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';

AppHelper.toNamed(AppRoutes.explore);
AppHelper.offAllNamed(AppRoutes.shell);
```

**Add a route:** `npx flutter-forge feature cart` or edit `app_routes.dart` + `app_pages.dart` (keep `// FORGE:*` markers).

---

## Folder map

```
lib/
├── main.dart, app.dart
├── routes/           # AppRoutes, AppPages
├── bindings/         # InitialBindings (global DI)
├── core/
│   ├── config/       # AppConfig (.env)
│   ├── constants/    # Colors, sizes, texts
│   ├── theme/        # Light/dark themes
│   ├── utils/        # Validators, formatters, helpers, logger
│   ├── exceptions/   # AppException + handler
│   ├── popups/       # Snackbars, dialogs
│   └── network/      # Connectivity
├── data/
│   ├── local/        # SQLite helper, DAOs
│   └── repositories/ # SettingsRepository, …
├── common/
│   ├── layouts/      # PageWrapper, GridLayout, …
│   └── widgets/      # Shared buttons, loaders, …
└── features/         # One folder per feature
    └── <name>/
        ├── bindings/
        ├── controllers/
        ├── views/
        ├── models/     # optional
        └── widgets/
```

---

## GetX cheat sheet

| Task | Where |
|------|-------|
| Global services | `bindings/initial_bindings.dart` |
| Screen logic | `features/<x>/controllers/` |
| Screen UI | `features/<x>/views/` (extend `GetView<Controller>`) |
| Reactive UI | `Obx(() => …)` around widgets using `.obs` |
| Register controller | `features/<x>/bindings/` or route `binding:` in `app_pages.dart` |

---

## Data & settings

- **Theme mode** — `SettingsRepository.setThemeMode` (stored in SQLite)
- **Onboarding done** — `setOnboardingComplete()` / `hasSeenOnboarding()`
- **New table** — bump DB version in `database_helper.dart`, add DAO + repository

<% if (includeNotes) { %>
- **Sample notes** — `NotesDao` + Explore list (demo only; remove for production)
<% } %>

---

## Environment variables

1. Copy `.env.example` → `.env`
2. Fill `API_BASE_URL`, `API_KEY`, `APP_ENV`
3. Read via `AppConfig` — never hardcode secrets

**Do not commit `.env`.**

---

## Daily commands

```bash
flutter pub get
flutter run
flutter analyze
flutter test
npx flutter-forge feature my_feature
```

---

## Suggested next steps

1. Change splash branding and `app_texts.dart`
2. Run `npx flutter-forge feature auth` (or your first real feature)
3. Point `AppConfig` at your API and add a repository
4. Remove demo counter / sample data when ready
5. Run `flutter analyze` before each commit

For deeper docs, see the [Flutter Forge repository](https://github.com/salim1334/flutter-forge/tree/main/docs).
