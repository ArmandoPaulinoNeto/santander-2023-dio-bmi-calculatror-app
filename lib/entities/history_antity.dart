import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HistoryEntity extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  double? bmi;

  @HiveField(2)
  String? assessment;

  HistoryEntity({this.name, this.bmi, this.assessment});

  Map<String, dynamic> toMap() {
    return {'name': name, 'bmi': bmi, 'assessment': assessment};
  }

  toEntity(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (index) => 
      HistoryEntity(name: maps[index]['name'], bmi: maps[index]['bmi'], assessment: maps[index]['assessment'])
    );
  }

  @override
  String toString() {
    return "Name: $name | BMI: $bmi | Assessmente: $assessment";
  }
}
