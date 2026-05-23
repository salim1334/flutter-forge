<% if (includeNotes) { %>
import 'package:sqflite/sqflite.dart';
import 'package:<%= packageName %>/data/local/database_helper.dart';
import 'package:<%= packageName %>/data/local/tables.dart';

class NotesDao {
  Future<Database> get _db => DatabaseHelper.instance.database;

  Future<List<Map<String, Object?>>> getAll() async {
    final db = await _db;
    return db.query(DbTables.notes, orderBy: 'created_at DESC');
  }

  Future<void> insert({required String title, String? body}) async {
    final db = await _db;
    await db.insert(DbTables.notes, {
      'title': title,
      'body': body ?? '',
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
<% } %>
