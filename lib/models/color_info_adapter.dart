import 'package:hive/hive.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

class ColorInfoAdapter extends TypeAdapter<ColorInfo> {
  @override
  final int typeId = 2;

  @override
  ColorInfo read(BinaryReader reader) {
    final Map<String, dynamic> colorMap = Map<String, dynamic>.from(reader.readMap());
    return ColorInfo.fromJson(colorMap);
  }

  @override
  void write(BinaryWriter writer, ColorInfo obj) {
    writer.writeMap(obj.toJson());
  }
}