import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/app.dart';
import 'package:<%= packageName %>/core/config/app_config.dart';
import 'package:<%= packageName %>/data/local/database_helper.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  AppConfig.validate();

  await DatabaseHelper.instance.database;
  Get.put(SettingsRepository(), permanent: true);

  runApp(const ForgeApp());
}
