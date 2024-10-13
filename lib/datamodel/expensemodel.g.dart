// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expensemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 3;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      food: fields[0] as String,
      travelfare: fields[1] as String,
      clothes: fields[2] as String,
      stay: fields[3] as String,
      medicine: fields[4] as String,
      other: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.food)
      ..writeByte(1)
      ..write(obj.travelfare)
      ..writeByte(2)
      ..write(obj.clothes)
      ..writeByte(3)
      ..write(obj.stay)
      ..writeByte(4)
      ..write(obj.medicine)
      ..writeByte(5)
      ..write(obj.other);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
