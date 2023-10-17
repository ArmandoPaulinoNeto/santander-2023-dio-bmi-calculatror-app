import 'package:bmi_calculator_app/entities/history_antity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryEntityAdapter extends TypeAdapter<HistoryEntity> {

  @override
  final typeId = 0;

  @override
  HistoryEntity read(BinaryReader reader) {
    return HistoryEntity(name: reader.readString(), bmi: reader.readDouble(), assessment: reader.readString());
  }

  @override
  void write(BinaryWriter writer, HistoryEntity obj) {
    writer.writeString(obj.name!);
    writer.writeDouble(obj.bmi!);
    writer.writeString(obj.assessment!);
  }
}
