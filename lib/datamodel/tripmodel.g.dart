// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tripmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 1;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      name: fields[1] as String,
      place: fields[0] as String,
      budget: fields[2] as String,
      image: fields[3] as String,
      enddate: fields[5] as DateTime?,
      todolist: (fields[6] as List?)?.cast<TodoListModel>(),
      expense: fields[7] as ExpenseModel?,
      journalKeys: (fields[8] as List?)?.cast<int>(),
      startdate: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.place)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.budget)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.startdate)
      ..writeByte(5)
      ..write(obj.enddate)
      ..writeByte(6)
      ..write(obj.todolist)
      ..writeByte(7)
      ..write(obj.expense)
      ..writeByte(8)
      ..write(obj.journalKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
