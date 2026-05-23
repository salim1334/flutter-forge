# CLI reference

Flutter Forge ships two binaries from the same package:

| Binary | Typical usage |
|--------|-----------------|
| `create-flutter-forge` | `npm create flutter-forge@latest` (recommended for new apps) |
| `flutter-forge` | Subcommands inside an existing forged project |

---

## `create` — new project

### Interactive

```bash
npm create flutter-forge@latest my_shop
```

Prompts:

1. **Project name** — folder name and Dart package name (e.g. `my_shop`)
2. **Organization** — bundle ID prefix (e.g. `com.mycompany` → `com.mycompany.my_shop`)
3. **Platforms** — android, ios, web, windows, macos, linux
4. **Sample notes table** — optional SQLite demo table on Explore screen
5. **Description** — written into `pubspec.yaml`

### Non-interactive

```bash
npm create flutter-forge@latest my_shop -- --yes
npm create flutter-forge@latest my_shop -- --yes --org com.mycompany --platforms android,ios,web
npm create flutter-forge@latest my_shop -- --yes --no-notes
```

### Flags

| Flag | Description |
|------|-------------|
| `-y, --yes` | Skip prompts; use defaults |
| `--org <org>` | Bundle ID organization (default: `com.example`) |
| `--platforms <list>` | Comma-separated platforms (default: `android,ios`) |
| `--no-notes` | Do not create the sample `notes` SQLite table |
| `--dry-run` | Print what would happen; do not write files |
| `--skip-flutter-create` | Only apply Forge templates (project folder must already exist) |

### What runs under the hood

1. Validates project name (npm + Dart rules)
2. Runs `flutter create --org … --platforms …`
3. Replaces `lib/` and `test/` with Forge templates
4. Merges dependencies into `pubspec.yaml`
5. Writes `analysis_options.yaml`, `.env.example`, copies `.env` if missing
6. Runs `flutter pub get` and `flutter analyze --no-fatal-infos`

---

## `feature` — add a feature module

Run **inside** a Flutter Forge project (must contain `lib/routes/app_pages.dart`).

```bash
cd my_shop
npx flutter-forge feature cart
```

### Options

| Flag | Description |
|------|-------------|
| `--with-model` | Also create `models/cart_model.dart` |
| `--route <path>` | Custom route (default: `/cart` from feature name) |
| `--no-binding` | Skip `bindings/cart_binding.dart` (register controller manually) |

### Examples

```bash
npx flutter-forge feature cart --with-model
npx flutter-forge feature product_details --route /products/details
npx flutter-forge feature auth --no-binding
```

### What gets created

```
lib/features/cart/
├── bindings/cart_binding.dart      # unless --no-binding
├── controllers/cart_controller.dart
├── views/cart_view.dart
├── models/cart_model.dart          # with --with-model
└── widgets/.gitkeep
```

### Route wiring (automatic)

The CLI inserts entries at marker comments:

- `lib/routes/app_routes.dart` → `// FORGE:ROUTES`
- `lib/routes/app_pages.dart` → `// FORGE:IMPORTS` and `// FORGE:PAGES`

If you add routes manually, keep those markers so future `feature` commands still work.

---

## Apply Forge to an existing Flutter app

For a project you already created with `flutter create`:

```bash
cd my_existing_app
npx flutter-forge create . --skip-flutter-create --yes
```

**Warning:** This **replaces** `lib/` and `test/`. Commit or back up first.

Then add features as usual:

```bash
npx flutter-forge feature checkout
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Flutter SDK not found` | Install Flutter; ensure `flutter` is on PATH |
| `Directory already exists` | Choose a new name or use an empty folder |
| `Not a Flutter Forge project` | Run `feature` from project root with `lib/routes/app_pages.dart` |
| `Feature already exists` | Pick a new name or delete the existing feature folder |
| `flutter analyze` warnings | Run `flutter analyze`; infos are non-fatal with Forge defaults |
