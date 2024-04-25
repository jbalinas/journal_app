
import 'package:journal/utils/uuid_maker.dart';

class JournalEntry {
  final String text;
  final UUIDString uuid;
  final DateTime updatedAt;
  final DateTime createdAt;

  factory JournalEntry({text=""}) {
    final when = DateTime.now();
    return JournalEntry.withTextUUIDUpdatedAtCreatedAt(text: text, uuid: UUIDMaker.generateUUID(), 
      updatedAt: when, createdAt: when);
  }

  JournalEntry.withTextUUIDUpdatedAtCreatedAt({required this.text, required this.uuid, required this.updatedAt, required this.createdAt});
  
  JournalEntry.withUpdatedText(JournalEntry entry, newText) : uuid=entry.uuid, createdAt=entry.createdAt, updatedAt=DateTime.now(), text=newText;
}

