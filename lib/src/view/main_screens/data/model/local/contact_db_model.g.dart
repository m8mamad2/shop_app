// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConcatsDBModelAdapter extends TypeAdapter<ConcatsDBModel> {
  @override
  final int typeId = 3;

  @override
  ConcatsDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConcatsDBModel(
      fields[7] as String?,
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[8] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, ConcatsDBModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.collegeEducation)
      ..writeByte(3)
      ..write(obj.highSchoolEducation)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.number)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcatsDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
