// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity_with_phone.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityWithPhoneAdapter extends TypeAdapter<UserEntityWithPhone> {
  @override
  final int typeId = 0;

  @override
  UserEntityWithPhone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntityWithPhone()
      ..phone = fields[0] as String?
      ..uid = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, UserEntityWithPhone obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.phone)
      ..writeByte(1)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityWithPhoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
