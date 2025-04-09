// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_loginModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLoginModelAdapter extends TypeAdapter<HiveLoginModel> {
  @override
  final int typeId = 0;

  @override
  HiveLoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLoginModel(
      status: fields[0] as bool,
      message: fields[1] as String,
      data: fields[2] as HiveLoginModelData,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLoginModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLoginModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveLoginModelDataAdapter extends TypeAdapter<HiveLoginModelData> {
  @override
  final int typeId = 1;

  @override
  HiveLoginModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLoginModelData(
      imageUrl: fields[0] as String,
      id: fields[1] as String,
      username: fields[2] as String,
      password: fields[3] as String,
      createdAt: fields[4] as String,
      v: fields[5] as int,
      role: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLoginModelData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.v)
      ..writeByte(6)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLoginModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
