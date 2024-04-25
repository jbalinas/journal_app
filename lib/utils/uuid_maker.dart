import 'package:uuid/uuid.dart';

typedef UUIDString = String;

class UUIDMaker{
  static const uuid = const Uuid();

  static UUIDString generateUUID(){
    return uuid.v4();
  }
}