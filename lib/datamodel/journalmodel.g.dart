// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journalmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalModelAdapter extends TypeAdapter<JournalModel> {
  @override
  final int typeId = 4;

  @override
  JournalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalModel(
      content: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JournalModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
