import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE casesPortal(
        caseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        caseType TEXT,
        caseNo TEXT,
        caseYear TEXT,
        location TEXT,
        mobile TEXT
      )
      """);

    await database.execute("""CREATE TABLE cca3Portal(
        caseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        crType TEXT,
        crNo TEXT,
        crYear TEXT,
        location TEXT,
        mobile INTEGER
      )
      """);

    await database.execute("""CREATE TABLE cca4Portal(
        caseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        crType TEXT,
        crNo TEXT,
        crYear TEXT,
        location TEXT,
        mobile INTEGER
      )
      """);

    await database.execute("""CREATE TABLE version_id(
        Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        version_code TEXT
      )
      """);

  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'androidsqlite.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String casetype, String caseno, String caseyear, String bench,String mnumber) async {
    final db = await SQLHelper.db();

    final data = {'caseType': casetype, 'caseNo': caseno, 'caseYear': caseyear, 'location': bench, 'mobile': mnumber};
    final id = await db.insert('casesPortal', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('casesPortal', orderBy: "caseId");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('casesPortal', where: "caseId = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String casetype, String caseno, String caseyear, String bench) async {
    final db = await SQLHelper.db();

    final data = {
      'caseType': casetype,
      'caseNo': caseno,
      'caseYear': caseyear,
      'location': bench
    };

    final result =
    await db.update('casesPortal', data, where: "caseId = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("casesPortal", where: "caseId = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}