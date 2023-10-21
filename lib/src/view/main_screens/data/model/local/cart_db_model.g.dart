// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDBModelAdapter extends TypeAdapter<CartDBModel> {
  @override
  final int typeId = 1;

  @override
  CartDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartDBModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as num,
      fields[3] as String,
      fields[4] as int,
      fields[5] as dynamic,
      fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CartDBModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.howmuch)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
