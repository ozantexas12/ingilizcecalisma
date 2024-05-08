// ignore_for_file: depend_on_referenced_packages

import 'package:ingilizcecalisma/database/models/list.dart';
import 'package:ingilizcecalisma/database/models/words.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  late Database _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      return await _initDatabase("easy.db");
    }
  }

  Future<Database> _initDatabase(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async
  {
    await db.execute('''
    
    CREATE TABLE IF NOT EXİSTS $tableNameLists(
    ${ListsTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT
    ${ListsTableFields.name}  TEXT NOT NULL
    )
    ''');












    await db.execute('''
      CREATE TABLE IF NOT EXİSTS $tableNameWords(
        ${WordTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${WordTableFields.list_id} INTEGER NOT NULL,
        ${WordTableFields.word_eng} TEXT NOT NULL,
        ${WordTableFields.word_tr} TEXT NOT NULL,
        ${WordTableFields.status} INTEGER NOT NULL
        FOREIGN KEY (${WordTableFields.list_id}) REFERENCES $tableNameLists(${ListsTableFields.id})
      )
    ''');
  }
}
