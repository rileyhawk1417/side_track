// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveHabitNotesAdapter extends TypeAdapter<HiveHabitNotes> {
  @override
  final int typeId = 1;

  @override
  HiveHabitNotes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveHabitNotes(
      appflowyDoc: (fields[1] as Map).cast<String, dynamic>(),
      docName: fields[0] as String,
      dateTime: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveHabitNotes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.docName)
      ..writeByte(1)
      ..write(obj.appflowyDoc)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveHabitNotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
