// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 4;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      id: fields[0] as String?,
      label: fields[1] as String?,
      country: fields[2] as String?,
      city: fields[3] as String?,
      apartment: fields[4] as String?,
      street: fields[5] as String?,
      block: fields[6] as String?,
      zipCode: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.apartment)
      ..writeByte(5)
      ..write(obj.street)
      ..writeByte(6)
      ..write(obj.block)
      ..writeByte(7)
      ..write(obj.zipCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
