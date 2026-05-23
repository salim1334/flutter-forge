# Working with existing projects

Flutter Forge supports two workflows.

---

## Workflow A — New app (default)

```bash
npm create flutter-forge@latest my_app
```

Official `flutter create` runs first — you keep all platform folders, tests, and tooling. Forge only replaces `lib/`, merges `pubspec.yaml`, and adds config files.

**You do not lose:** Android/iOS/Web projects, bundle IDs, `flutter doctor` compatibility, or Flutter SDK upgrades to platform templates.

---

## Workflow B — Already have a Flutter app

### Full Forge overlay (destructive to `lib/`)

```bash
cd my_existing_app
git checkout -b add-flutter-forge
npx flutter-forge create . --skip-flutter-create --yes
```

This **replaces** `lib/` and `test/`. Merge your old code from git history into the new feature folders.

### Incremental — feature command only

If your app already follows similar structure (routes + GetX), you can use only:

```bash
npx flutter-forge feature payments --with-model
```

Requirements for auto route wiring:

- `lib/routes/app_routes.dart` with `// FORGE:ROUTES` marker
- `lib/routes/app_pages.dart` with `// FORGE:IMPORTS` and `// FORGE:PAGES` markers

Add markers manually if missing:

```dart
// app_routes.dart
abstract final class AppRoutes {
  static const home = '/home';
  // FORGE:ROUTES
}

// app_pages.dart
import '...';
// FORGE:IMPORTS

abstract final class AppPages {
  static final pages = <GetPage>[
    // ...existing pages...
    // FORGE:PAGES
  ];
}
```

---

## Migrating from another architecture

| From | Approach |
|------|----------|
| setState only | Move screens into `features/*/views`, logic into controllers |
| Provider / Riverpod | Keep providers or gradually replace with GetX repositories |
| BLoC | Map BLoC → `GetxController` + `.obs` |
| Imperative `Get.to()` | Prefer `AppRoutes` + `AppHelper.toNamed` |

Forge does not auto-convert old code — plan a branch and migrate feature by feature.

---

## Team onboarding

1. Share repo + `.env.example` (never `.env`)
2. Point new devs to generated `FEATURES.md` and `README.md`
3. Document your route and naming conventions in `CONTRIBUTING.md` (optional)
4. Run `flutter analyze` in CI (see package `.github/workflows/ci.yml` for an example)
