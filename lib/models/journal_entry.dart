import 'package:journal/utils/uuid_maker.dart';
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry {
  @HiveField(0)
  // Text content reflecting what user is grateful for today
  final String gratitudeText;

  @HiveField(1)
  // Text content describing highlight of user's day
  final String highlightText;

  @HiveField(2)
  // Unique identifier for journal entry, generated by UUIDMaker
  final UUIDString uuid;

  @HiveField(3)
  // TImestamp when entry was last updated
  final DateTime updatedAt;

  @HiveField(4)
  // Timestamp when entry was created
  final DateTime createdAt;

  // A journal entry
  JournalEntry({
    this.gratitudeText = '',
    this.highlightText = '',
    required this.createdAt,
    required this.updatedAt,
    required this.uuid,
  });

  // Creates a new entry w/ current date-time
  JournalEntry.newEntry({
    this.gratitudeText = '',
    this.highlightText = '',
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        uuid = UUIDMaker.generateUUID();

  // Initializes a JournalEntry with all the properties
  JournalEntry.withTextUUIDUpdatedAtCreatedAt(
      {required this.gratitudeText,
      required this.highlightText,
      required this.uuid,
      required this.updatedAt,
      required this.createdAt});

  // Updates existing JournalEntry with texts/updatedAt timestamp
  //  while keeping createdAt timestamp
  JournalEntry.withUpdates(JournalEntry entry,
      {String newGratitudeText = '', String newHighlightText = ''})
      : uuid = entry.uuid,
        createdAt = entry.createdAt,
        updatedAt = DateTime.now(),
        gratitudeText =
            newGratitudeText.isEmpty ? entry.gratitudeText : newGratitudeText,
        highlightText =
            newHighlightText.isEmpty ? entry.highlightText : newHighlightText;
}
