import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:<%= packageName %>/data/local/tables.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const int _dbVersion = 1;
  static const String _dbName = 'forge_app.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DbTables.appSettings} (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

<% if (includeNotes) { %>
    await db.execute('''
      CREATE TABLE ${DbTables.notes} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        body TEXT,
        created_at TEXT NOT NULL
      )
    ''');
<% } %>
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add migrations here when _dbVersion increases
  }
}
