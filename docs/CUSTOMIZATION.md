# Customization guide — from splash to deep

A practical order for editing your forged app without getting lost.

---

## Level 1 — Branding & first impression (30 minutes)

### Welcome message & app name

| What | File |
|------|------|
| Welcome text on splash | `lib/core/constants/app_texts.dart` → `welcomeMessage` |
| App name on splash | `lib/core/constants/app_texts.dart` → `appName` |
| Window title | `lib/app.dart` → `title` in `GetMaterialApp` |

### Colors & typography

| What | File |
|------|------|
| Brand colors | `lib/core/constants/app_colors.dart` |
| Spacing, radius | `lib/core/constants/app_sizes.dart` |
| Light/dark themes | `lib/core/theme/app_theme.dart` |
| Buttons, inputs, app bar | `lib/core/theme/custom_themes/*.dart` |

### Splash screen UI

1. Open `lib/features/splash/views/splash_view.dart`
2. Change icon, layout, animation
3. Adjust delay in `lib/features/splash/controllers/splash_controller.dart` (`Duration(seconds: 2)`)

---

## Level 2 — Onboarding & navigation (1–2 hours)

### Onboarding slides

Edit `pages` in `lib/features/onboarding/controllers/onboarding_controller.dart`:

```dart
final List<(...)> pages = [
  (title: '...', body: '...', icon: Icons....),
];
```

### Bottom navigation tabs

1. `lib/features/shell/views/main_shell_view.dart` — add widget to `pages` + `NavigationDestination`
2. `lib/features/shell/bindings/main_shell_binding.dart` — `Get.lazyPut` for new tab’s controller
3. Create the feature folder (or `npx flutter-forge feature orders`)

### Add a new screen (named route)

**Option A — CLI (recommended):**

```bash
npx flutter-forge feature cart --with-model
```

**Option B — Manual:**

1. Create `lib/features/cart/` (bindings, controller, view)
2. Add `AppRoutes.cart` in `app_routes.dart` (above `// FORGE:ROUTES`)
3. Add `GetPage` in `app_pages.dart` (above `// FORGE:PAGES`)
4. Navigate: `AppHelper.toNamed(AppRoutes.cart)`

---

## Level 3 — State & business logic

### Controller pattern

```dart
class CartController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Item> items = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async { /* ... */ }
}
```

### View pattern

```dart
class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => /* use controller.items */);
  }
}
```

### Forms

Use `AppValidator` from `lib/core/utils/validators/app_validator.dart` with `GlobalKey<FormState>` in the controller.

---

## Level 4 — Data & API

### Local settings / flags

Use `SettingsRepository` or extend `SettingsDao` — do not call SQLite from controllers directly.

### New database table

1. Bump `_dbVersion` in `database_helper.dart`
2. Add table name in `tables.dart`
3. Implement `onUpgrade` migration
4. Create DAO in `daos/`
5. Expose via a repository in `repositories/`

### API keys & base URL

1. Set values in `.env` (copy from `.env.example`)
2. Read via `AppConfig.apiBaseUrl` / `AppConfig.apiKey`
3. See `ExploreController` for logging a masked key in debug

---

## Level 5 — Shared UX

| Need | Use |
|------|-----|
| Success / error message | `AppPopups.showSuccessSnack` / `showErrorSnack` |
| Confirm delete | `AppPopups.showConfirmDialog` |
| Loading overlay | `AppPopups.showLoading()` / `hideLoading()` |
| Log debug info | `Get.find<AppLogger>().debug('...')` |
| Handle failures | `ExceptionHandler.show(e)` |
| Check internet | `Get.find<NetworkManager>().checkConnection()` |

---

## Level 6 — Remove demo code

When moving to production, consider removing:

| Demo | Location |
|------|----------|
| Counter on Home | `home_controller.dart` / `home_view.dart` |
| Sample notes list | `explore_*` + `notes_dao.dart` (if created) |
| Onboarding (optional) | Skip splash logic → go straight to `shell` |
| Extra routes | `app_pages.dart` entries you do not need |

---

## Suggested edit order for a real app

1. Branding (texts, colors, splash)
2. Auth feature (new `feature auth` + replace onboarding redirect in `splash_controller`)
3. Replace Explore with your main list screen
4. Wire real API in a `data/repositories/` class
5. Trim unused routes and demo controllers
6. Run `flutter analyze` before every commit
