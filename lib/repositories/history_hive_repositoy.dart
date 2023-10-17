import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import '../adapters/history_antity_adpter.dart';
import '../entities/history_antity.dart';

class HistoryHiveRepository {
  List<HistoryEntity> historyStorageHive = List.empty(growable: true);
  late LazyBox _box;

  HistoryHiveRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
  }

  _openBox() async {
    Hive.registerAdapter(HistoryEntityAdapter());
    _box = await Hive.openLazyBox("hive_storage");
  }

  createHistoryHive(HistoryEntity history) {
    _box.put(generateId(), history);
  }

  getAllUsersHistoryHive() {
    _box.keys.forEach((key) async {
      HistoryEntity history = await _box.get(key);
      if (!historyStorageHive.contains(history)) {
        historyStorageHive.add(history);
      }
    });
    return historyStorageHive;
  }

  generateId() {
    return Random().nextInt(200);
  }
}
