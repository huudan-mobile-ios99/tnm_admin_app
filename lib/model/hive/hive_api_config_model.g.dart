// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_api_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAPIConfigModelAdapter extends TypeAdapter<HiveAPIConfigModel> {
  @override
  final int typeId = 2;

  @override
  HiveAPIConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAPIConfigModel(
      rlEndpoint: fields[0] as String,
      slotEndpoint: fields[1] as String,
      rlEndpointSocket: fields[2] as String,
      slotEndpointSocket: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAPIConfigModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.rlEndpoint)
      ..writeByte(1)
      ..write(obj.slotEndpoint)
      ..writeByte(2)
      ..write(obj.rlEndpointSocket)
      ..writeByte(3)
      ..write(obj.slotEndpointSocket);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAPIConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
