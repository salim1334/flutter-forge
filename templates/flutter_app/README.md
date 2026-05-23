# <%= projectName %>

<%= description %>

Production-ready Flutter starter — **GetX**, feature folders, named routes, SQLite, and `.env` configuration. Forged with [Flutter Forge](https://www.npmjs.com/package/create-flutter-forge).

---

## Quick start

```bash
flutter pub get
# If .env is missing:
cp .env.example .env
flutter run
```

---

## Project docs

| Doc | Purpose |
|-----|---------|
| [FEATURES.md](./FEATURES.md) | **Start here** — routes, folders, launch flow, cheat sheets |
| `.env.example` | API keys template (copy to `.env`) |

---

## Architecture (summary)

- **Routes** — `lib/routes/app_routes.dart` + `app_pages.dart`
- **State** — GetX controllers + bindings per feature
- **Data** — Repositories → DAOs → SQLite (`lib/data/`)
- **UI shared** — `lib/common/widgets/` and `layouts/`
- **Theme** — `lib/core/theme/` + settings screen toggle

---

## Customize (common tasks)

| Goal | Location |
|------|----------|
| Change welcome message | `lib/core/constants/app_texts.dart` |
| Edit splash screen | `lib/features/splash/` |
| Add new screen | `npx flutter-forge feature <name>` |
| API base URL | `.env` → `AppConfig.apiBaseUrl` |
| Brand colors | `lib/core/constants/app_colors.dart` |

---

## Add a feature

```bash
npx flutter-forge feature cart
npx flutter-forge feature cart --with-model
```

---

## Quality

```bash
flutter analyze
flutter test
```

This project uses `flutter_lints` — see `analysis_options.yaml`.

---

## Production notes

- Never commit `.env`
- Prefer `--dart-define` or CI secrets for release builds
- Remove demo/sample code before shipping
