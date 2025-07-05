// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guess_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuessModelAdapter extends TypeAdapter<GuessModel> {
  @override
  final int typeId = 0;

  @override
  GuessModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuessModel(
      word: fields[0] as String,
      feedback: fields[1] as String,
      hints: (fields[2] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GuessModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.feedback)
      ..writeByte(2)
      ..write(obj.hints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuessModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
