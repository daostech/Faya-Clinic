// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyUserAdapter extends TypeAdapter<MyUser> {
  @override
  final int typeId = 3;

  @override
  MyUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUser(
      userId: fields[0] as String,
      userName: fields[1] as String,
      email: fields[2] as String,
      isActive: fields[3] as bool,
      gender: fields[4] as int,
      phoneNumber: fields[5] as String,
      dateBirth: fields[6] as String,
      dateCreated: fields[7] as String,
      imgUrl: fields[8] as String,
      token: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyUser obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.dateBirth)
      ..writeByte(7)
      ..write(obj.dateCreated)
      ..writeByte(8)
      ..write(obj.imgUrl)
      ..writeByte(9)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MyUserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
