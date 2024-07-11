// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 1;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car(
      model: fields[0] as String?,
      brand: fields[1] as String?,
      type: fields[2] as String?,
      baseColor: fields[3] as String?,
      price: fields[4] as double?,
      images: fields[5] as String?,
      exteriorColors: (fields[6] as List?)?.cast<ColorInfo>(),
      interiorColors: (fields[7] as List?)?.cast<ColorInfo>(),
      brakeColors: (fields[8] as List?)?.cast<ColorInfo>(),
      fuelTypes: (fields[9] as List?)?.cast<String>(),
      selectedExteriorColor: fields[10] as String?,
      selectedInteriorColor: fields[11] as String?,
      selectedBrakeColor: fields[12] as String?,
      selectedFuelType: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.baseColor)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.exteriorColors)
      ..writeByte(7)
      ..write(obj.interiorColors)
      ..writeByte(8)
      ..write(obj.brakeColors)
      ..writeByte(9)
      ..write(obj.fuelTypes)
      ..writeByte(10)
      ..write(obj.selectedExteriorColor)
      ..writeByte(11)
      ..write(obj.selectedInteriorColor)
      ..writeByte(12)
      ..write(obj.selectedBrakeColor)
      ..writeByte(13)
      ..write(obj.selectedFuelType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
