import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:<%= packageName %>/bindings/initial_bindings.dart';
import 'package:<%= packageName %>/data/local/database_helper.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';

bool _ffiInitialized = false;

/// Call once from `setUpAll` in tests.
void initForgeTestDatabase() {
  if (_ffiInitialized) return;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  _ffiInitialized = true;
}

/// Prepares GetX + SQLite for widget tests (not used by the real app).
Future<void> setupForgeTest() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initForgeTestDatabase();

  await dotenv.load(fileName: '.env', isOptional: true);

  Get.testMode = true;
  await Get.deleteAll(force: true);

  await DatabaseHelper.instance.database;
  InitialBindings().dependencies();

  if (!Get.isRegistered<SettingsRepository>()) {
    Get.put(SettingsRepository(), permanent: true);
  }
}

Future<void> tearDownForgeTest() async {
  await Get.deleteAll(force: true);
}
