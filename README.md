# Flutter Forge

**Forge a production-ready Flutter foundation in one command.**

Runs official `flutter create`, then scaffolds GetX, feature-based folders, named routes, SQLite, strict linting, `.env` config, and working sample screens — without Firebase.

```bash
npm create flutter-forge@latest my_app
cd my_app && flutter run
```

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) on your PATH
- [Node.js](https://nodejs.org/) 18+

---

## Quick start

```bash
# Interactive
npm create flutter-forge@latest my_shop

# Defaults (CI / fast)
npm create flutter-forge@latest my_shop -- --yes --org com.mycompany --platforms android,ios,web

# Add a feature later
cd my_shop
npx flutter-forge feature cart --with-model
```

---

## Documentation

| Guide | What you'll learn |
|-------|-------------------|
| [CLI reference](./docs/CLI.md) | All commands, flags, subcommands, troubleshooting |
| [Architecture](./docs/ARCHITECTURE.md) | How every piece fits: main → routes → features → data |
| [Customization](./docs/CUSTOMIZATION.md) | Edit from splash → onboarding → features → SQLite/API |
| [Existing projects](./docs/EXISTING_PROJECT.md) | Overlay Forge on `flutter create` apps, incremental use |
| [Publishing](./PUBLISHING.md) | Professional npm publish checklist |

Generated apps also include **`FEATURES.md`** and **`README.md`** in the project root.

---

## Commands at a glance

| Command | Description |
|---------|-------------|
| `npm create flutter-forge@latest [name]` | New project (recommended) |
| `npx flutter-forge create [name]` | Same, via `flutter-forge` binary |
| `npx flutter-forge feature <name>` | Scaffold feature + wire routes |

**Create flags:** `--yes`, `--org`, `--platforms`, `--no-notes`, `--dry-run`, `--skip-flutter-create`  
**Feature flags:** `--with-model`, `--route`, `--no-binding`

Details → [docs/CLI.md](./docs/CLI.md)

---

## What you get

- Official Flutter **android / ios / web / desktop** folders (from `flutter create`)
- **Feature modules** — `bindings/`, `controllers/`, `views/`, `widgets/`
- **Named routes** — `AppRoutes` + `AppPages` + `GetMaterialApp`
- **Themes** — Material 3 light/dark/system, persisted in SQLite
- **SQLite** — `DatabaseHelper`, DAOs, `SettingsRepository`
- **Core utilities** — validators, formatters, popups, logger, exceptions, device utils
- **`.env` + `AppConfig`** — safe API key pattern
- **`flutter_lints`** — strict `analysis_options.yaml` for beginners
- **Demo flow** — splash (welcome message) → onboarding → shell (home / explore / settings)

---

## Customize your app (short path)

1. **Splash copy** → `lib/core/constants/app_texts.dart`
2. **Colors / theme** → `lib/core/constants/app_colors.dart`, `lib/core/theme/`
3. **New screen** → `npx flutter-forge feature orders`
4. **API URL** → `.env` + `lib/core/config/app_config.dart`

Full walkthrough → [docs/CUSTOMIZATION.md](./docs/CUSTOMIZATION.md)

---

## Development (this repo)

```bash
git clone https://github.com/salim1334/flutter-forge.git   # update URL after you publish
cd flutter-forge
npm install
npm run build
node bin/flutter_forge.js --help
```

---

## License

MIT — see [LICENSE](./LICENSE)
