// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDBModelAdapter extends TypeAdapter<FavoriteDBModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteDBModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteDBModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
