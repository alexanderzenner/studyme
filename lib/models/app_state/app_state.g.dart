// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  final int typeId = 10;

  @override
  AppState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppState.ONBOARDING;
      case 1:
        return AppState.CREATING_DETAILS;
      case 2:
        return AppState.CREATING_PHASES;
      case 3:
        return AppState.DOING;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    switch (obj) {
      case AppState.ONBOARDING:
        writer.writeByte(0);
        break;
      case AppState.CREATING_DETAILS:
        writer.writeByte(1);
        break;
      case AppState.CREATING_PHASES:
        writer.writeByte(2);
        break;
      case AppState.DOING:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
