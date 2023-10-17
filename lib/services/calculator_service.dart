import 'package:bmi_calculator_app/entities/history_antity.dart';

import '../repositories/history_hive_repositoy.dart';
import '../repositories/history_shared_repositoy.dart';
import '../repositories/history_sqlite_repositoy.dart';

class CalculatorService {
  HistorySharedRepository historySharedRepository = HistorySharedRepository();
  HistoryHiveRepository historyHiveRepository = HistoryHiveRepository();
  HistorySqliteRepository historySqliteRepository = HistorySqliteRepository();

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  createHistoryStorage(String name, double bmi, String assessment, String locale) {

    HistoryEntity history = HistoryEntity(name: name, bmi: bmi, assessment: assessment);

    if (locale.contains("shared")) {
      historySharedRepository.createHistoryShared(history);
    }
    else if (locale.contains("hive")) {
      historyHiveRepository.createHistoryHive(history);
    } else {
      historySqliteRepository.createHistorySqlite(history);
    }
  }

  fetchAllHistoryShared() async {
    return await historySharedRepository.getAllHistoryShared();
  }

  fetchAllHistoryHive() {
    return historyHiveRepository.getAllUsersHistoryHive();
  }

  fetchAllHistorySqlite() {
    return historySqliteRepository.getAllUsersHistory();
  }

  String analyzeBMI(bmi) {
    var result = "";

    if (bmi < 16) {
      result = "Extreme Thinness";
    }
    if (bmi >= 16 && bmi < 17) {
      result = "Moderate Thinness";
    }
    if (bmi >= 17 && bmi < 18.5) {
      result = "Underweight";
    }
    if (bmi >= 18.5 && bmi < 25) {
      result = "Nomal Weight";
    }
    if (bmi >= 25 && bmi < 30) {
      result = "Overweight";
    }
    if (bmi >= 30 && bmi < 35) {
      result = "Obesity class I";
    }
    if (bmi >= 35 && bmi < 40) {
      result = "Obesity class II";
    }
    if (bmi >= 40) {
      result = "Obesity class III";
    }

    return result;
  }
}
