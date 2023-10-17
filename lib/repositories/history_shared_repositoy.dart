import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/history_antity.dart';

class HistorySharedRepository {
  late SharedPreferences storage;
  List<String> historyStorage = List.empty(growable: true);
  List<HistoryEntity> usersHistory = List.empty(growable: true);

  createHistoryShared(HistoryEntity history) async {
    storage = await SharedPreferences.getInstance();
    historyStorage.add("${history.name}#${history.bmi.toString()}#${history.assessment}");
    storage.setStringList("shared_storage", historyStorage);
  }

  getAllHistoryShared() async {
    storage = await SharedPreferences.getInstance();
    historyStorage = storage.getStringList("shared_storage")!;
    return List.generate(historyStorage.length , (index) => returnHistoryEntityList(historyStorage[index]));
  }

  HistoryEntity returnHistoryEntityList(String item){
    var itens = item.split("#");
    return HistoryEntity(name: itens[0], bmi: double.parse(itens[1]), assessment: itens[2]);
  }
}
