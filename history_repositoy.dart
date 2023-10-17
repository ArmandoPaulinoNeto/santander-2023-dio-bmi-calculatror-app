import 'dart:math';
import 'package:bmi_calculator_app/adapters/history_antity_adpter.dart';
import 'package:bmi_calculator_app/entities/history_antity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  late SharedPreferences storage;
  List<String> historyStorage = List.empty(growable: true);
  List<HistoryEntity> historyStorageHive = List.empty(growable: true);
  late LazyBox _box;

  HistoryRepository() {
    _startRepository();
  }

  createHistoryShared(HistoryEntity history) async {
    storage = await SharedPreferences.getInstance();
    historyStorage.add("${history.name}#${history.bmi.toString()}#${history.assessment}");
    storage.setStringList("histories", historyStorage);
  }

  Future<List<String>?> getAllHistoryShared() async {
    storage = await SharedPreferences.getInstance();
    return storage.getStringList("history_users");
  }

  _startRepository() async {
    await _openBox();
    await _readUsersHistory();
  }

  _openBox() async {
    Hive.registerAdapter(HistoryEntityAdapter());
    _box = await Hive.openLazyBox("history_users");
  }

  createHistoryHive(HistoryEntity history) async {
    _box.put(generateId(), history);
  }
  
  getAllUsersHistoryHive() async {    
    return historyStorageHive;
  }

  _readUsersHistory() {
    _box.keys.forEach((key) async {     
      historyStorageHive.add(await _box.get(key));
    });
    return historyStorageHive;
  }

  createHistorySqlite(HistoryEntity history) async {}

  generateId() {
    return Random().nextInt(200);
  }
}
