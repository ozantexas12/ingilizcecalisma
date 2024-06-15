import 'package:flutter/foundation.dart';
import 'package:ingilizcecalisma/database/models/list.dart';
import 'package:ingilizcecalisma/database/models/words.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DB {
  static final DB instance = DB._init();
  Database? _database;

  DB._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    } else {
      _database = await _initDatabase("easy.db");
      return _database!;
    }
  }

  Future<Database> _initDatabase(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableNameLists(
        ${ListsTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ListsTableFields.name} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableNameWords(
        ${WordTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${WordTableFields.list_id} INTEGER NOT NULL,
        ${WordTableFields.word_eng} TEXT NOT NULL,
        ${WordTableFields.word_tr} TEXT NOT NULL,
        ${WordTableFields.status} INTEGER NOT NULL,
        FOREIGN KEY (${WordTableFields.list_id}) REFERENCES $tableNameLists(${ListsTableFields.id})
      )
    ''');
  }

  Future<Lists> insertList(Lists lists) async {
    final db = await instance.database;
    final id = await db.insert(tableNameLists, lists.toJson());
    return lists.copy(id: id);
  }

  Future<Word> insertWord(Word word) async {
    final db = await instance.database;
    final id = await db.insert(tableNameWords, word.toJson());
    return word.copy(id: id);
  }

  Future<List<Word>> readWordByList(int? listsID) async {
    final db = await instance.database;
    const orderBy = '${WordTableFields.id} ASC';
    final result = await db.query(tableNameWords,
        orderBy: orderBy,
        where: '${WordTableFields.list_id} = ?',
        whereArgs: [listsID]);
    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Map<String, Object?>>> readListsAll() async {
    final db = await instance.database;

    List<Map<String, Object?>> res = [];
    List<Map<String, Object?>> lists = await db.rawQuery("SELECT id, name FROM list");

    await Future.forEach(lists, (element) async {
      var wordInfoByList = await db.rawQuery('''
      SELECT 
        (SELECT COUNT(*) FROM words WHERE list_id = ?) AS sum_word,
        (SELECT COUNT(*) FROM words WHERE status = 0 AND list_id = ?) AS sum_unlearned
    ''', [element["id"], element["id"]]);

      Map<String, Object?> temp = Map.of(wordInfoByList[0]);
      temp["name"] = element["name"];
      temp["list_id"] = element["id"];
      res.add(temp);
    });

    if (kDebugMode) {
      print(res);
    }
    return res;
  }


  Future<int> updateWords(Word word) async {
    final db = await instance.database;
    return db.update(tableNameWords, word.toJson(),
        where: '${WordTableFields.id} = ?', whereArgs: [word.id]);
  }

  Future<int> updateLists(Lists lists) async {
    final db = await instance.database;
    return db.update(tableNameLists, lists.toJson(),
        where: '${ListsTableFields.id} = ?', whereArgs: [lists.id]);
  }

  Future<int> deleteWord(int id) async {
    final db = await instance.database;
    return db.delete(tableNameWords,
        where: '${WordTableFields.id} = ?', whereArgs: [id]);
  }

  Future<int> deleteList(int id) async {
    final db = await instance.database;
    int result = await db.delete(tableNameLists,
        where: '${ListsTableFields.id} = ?', whereArgs: [id]);
    if (result == 1) {
      await db.delete(tableNameWords,
          where: '${WordTableFields.list_id} = ?', whereArgs: [id]);
    }
    return result;
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
