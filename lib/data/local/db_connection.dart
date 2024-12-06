import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  DBConnection._();

  //Singleton
  static DBConnection getInstance = DBConnection._();

  //table note
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SN0 = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "description";

  Database? myDB;

  //db Open (path -> if exists, then open. else create db)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");

    return await openDatabase(
      dbPath,
      onCreate:(db, version) {
        print("Database created with version: $version");

        //create tables here
        db.execute(
            "CREATE TABLE $TABLE_NOTE ("
                "$COLUMN_NOTE_SN0 INTEGER PRIMARY KEY AUTOINCREMENT, "
                "$COLUMN_NOTE_TITLE TEXT, "
                "$COLUMN_NOTE_DESC TEXT)"
        );
        //Multiple tables here

      print("Table $TABLE_NOTE created successfully");
      }, version: 3);
  }

  //insertion
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : mTitle,
      COLUMN_NOTE_DESC : mDesc
    });

    return rowsEffected>0;
  }

  //fetching or reading all data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    ///Select * from note
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE,);
    return mData;
  }

  //Update data
  Future<bool> updateNote({required String title, required String desc, required int sno}) async {
    var db = await getDB();
    
    int rowsAffected = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : title,
      COLUMN_NOTE_DESC : desc,
      },
      where: "$COLUMN_NOTE_SN0 = $sno"
    );
    return rowsAffected > 0;
  }

  ///delete note or data
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsEffected = await db.delete(TABLE_NOTE, where: "$COLUMN_NOTE_SN0 = ?", whereArgs: ['$sno']);
    return rowsEffected > 0;
  }
}

