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

  Future<Lists> insertList(Lists lists) async{
    final db =await instance.database;
    final id = await db.insert(tableNameLists, lists.toJson());

    return lists.copy(id: id);
  }

  Future<Word> insertWord(Word word) async {
    final db = await instance.database;
    final id = await db.insert(tableNameWords, word.toJson());
    return word.copy(id: id);
  }

  Future<List<Word>> readWordByList(int ?listsID) async{
    final db=await instance.database;
    const orderBy='${WordTableFields.id} ASC';
    final result = await db.query(tableNameWords,orderBy: orderBy,where: '${WordTableFields.list_id}= ?',whereArgs: [listsID]);
    
    return result.map((json) => Word.fromJson(json)).toList();
  }
  Future<List<Lists>> readListsAll() async{
    final db=await instance.database;
    const orderBy='${ListsTableFields.id} ASC';
    final result = await db.query(tableNameLists,orderBy: orderBy);
    return result.map((json) => Lists.fromJson(json)).toList();
  }

  Future<int> updateWords(Word word) async {
    final db = await instance.database;
    return db.update(tableNameWords, word.toJson(),where: '${WordTableFields.id}= ?',whereArgs:[word.id] );
  }

  Future<int>updateLists(Lists lists) async {
    final db=await instance.database;
    return db.update(tableNameLists, lists.toJson(),where: '${ListsTableFields.id}=?',whereArgs: [lists.id]);
  }

  Future<int> deleteWord(int id) async{
    final db=await instance.database;
    return db.delete(tableNameWords,where: '${WordTableFields.id}=?',whereArgs: [id]);
  }
  Future<int> deleteList(int id) async{
    final db=await instance.database;
    int result =await db.delete(tableNameLists,where: '${ListsTableFields.id}=?',whereArgs:[id] );
    if(result==1){
      db.delete(tableNameWords,where: '${WordTableFields.list_id}=?',whereArgs:[id] );
    }
    return result;
  }


  Future close() async{
    final db= await instance.database;
    db.close(); 
  }


}
