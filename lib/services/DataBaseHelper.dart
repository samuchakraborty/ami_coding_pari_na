import 'dart:async';
import 'dart:io' as io;

import 'package:ami_coding_pari_na/models/UserModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  late Database _db;
  static const String ID = 'id';
  static const String USER_NAME = 'userName';
  static const String USER_PASSWORD = 'password';
  static const String USER_MOBILE = 'mobile';

  static const String USER_TABLE = 'user';
  static const String USER_DB_NAME = 'user.db';

  Future<Database> get db async {
    // if (_db != null) {
    //   return _db;
    // }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, USER_DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $USER_TABLE ($ID INTEGER PRIMARY KEY autoincrement, $USER_NAME TEXT, $USER_MOBILE NUMBER, $USER_PASSWORD TEXT)");
  }

  Future save(User user) async {
    var dbClient = await db;
    int id = await dbClient.insert(USER_TABLE, user.toUser());
     print(id);
    return id;
    //var query;
    // await dbClient.transaction((txn) async {
    //   var query =
    //       "INSERT INTO $USER_TABLE ($USER_NAME, $USER_MOBILE, $USER_PASSWORD) VALUES ('" +
    //           userName +
    //           "', '" +
    //           mobile +
    //           "', '" +
    //           password +
    //           "')";
    //   print(query);
    //   int lastId = await txn.rawInsert(query);
    //   print(lastId);
    //
    //   return lastId;
    // });
  }

  Future<List<User>> getEmployees() async {
    var dbClient = await db;
    List<Map<String, dynamic>> mapss = await dbClient.query(USER_TABLE,
        columns: [ID, USER_NAME, USER_PASSWORD, USER_MOBILE]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    // List user = [];
    // if (mapss.length > 0) {
    //   for (int i = 0; i < mapss.length; i++) {
    //     //user.add(User(mapss![i]));
    //     print(mapss[i]);
    //   }
    // }
    return List.generate(mapss.length, (i) {
      return User(
        id: mapss[i]['id'],
        userName: mapss[i]['userName'],
        password: mapss[i]['password'],
        mobile: mapss[i]['mobile']
      );
    });


   // return user;
  }

  //
  Future<User?> getUser({required int lastId}) async {
    var dbClient = await db;
    // List<Map> mapss = await dbClient.query(USER_TABLE,
    //     columns: [ID, USER_NAME, USER_PASSWORD, USER_MOBILE]);
    // //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    // List<User> user = [];
    // if (mapss.length > 0) {
    //   for (int i = 0; i < mapss.length; i++) {
    //     //user.add(User(mapss![i]));
    //     print(mapss[i]);
    //   }
    // }

    var result = await dbClient.query(USER_TABLE, where: "id=?", whereArgs: [lastId]);
    return User.fromMap(result.first) ;

    //return user;
  }









  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(USER_TABLE, where: '$ID = ?', whereArgs: [id]);
  // }

  // Future<int> update(User employee) async {
  //   var dbClient = await db;
  //   return await dbClient.update(USER_TABLE, employee.toMap(),
  //       where: '$ID = ?', whereArgs: [employee.id]);
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
