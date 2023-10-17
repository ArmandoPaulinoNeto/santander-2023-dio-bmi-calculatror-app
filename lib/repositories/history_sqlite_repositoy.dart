import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/history_antity.dart';

class HistorySqliteRepository {
  List<HistoryEntity> historyStorageHive = List.empty(growable: true);
  var database;

  HistorySqliteRepository() {
    database = () async => await openDatabaseSqlite();
  }

  createHistorySqlite(HistoryEntity history) async {
    final db = await database();
    db.insert('users_history', history.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  getAllUsersHistory() async {
    var db = await database();
    List<Map<String, dynamic>> maps = await db.query('users_history');
    return HistoryEntity().toEntity(maps);
  }

  openDatabaseSqlite() async {
    return openDatabase(
      join(await getDatabasesPath(), 'users_history_sqlite.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE users_history(id INTERGER PRIMARY KEY, name VARCHAR(25), assessment VARCHAR(15), bmi DOUBLE)');
      },
      version: 1,
    );
  }
}
