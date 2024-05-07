// import 'package:journal/models/journal.dart';
// import 'package:journal/models/journal_entry.dart';
// import 'package:journal/utils/uuid_maker.dart';

// EVERYTHING IS COMMENTED OUT BC WE DON'T NEED IT ANYMORE
// JUST KEEPING THIS HERE FOR GRADING PURPOSES
// // Mock journal with entries for noodlin around with views
// Journal makeMockData() {
//   Journal journalMocker = Journal();

//   // List of mock entries
//   List<JournalEntry> mockEntries = [
//     JournalEntry(
//         gratitudeText: 'Steven got me steak',
//         highlightText: 'I ate steak',
//         uuid: UUIDMaker.generateUUID(),
//         updatedAt: DateTime.now(),
//         createdAt: DateTime.now()),
//     JournalEntry(
//         gratitudeText: 'I have a cat',
//         highlightText: 'My cat licked my nose',
//         uuid: UUIDMaker.generateUUID(),
//         updatedAt: DateTime.now(),
//         createdAt: DateTime.now()),
//     JournalEntry(
//         gratitudeText: 'I am not starving',
//         highlightText: 'I got a funny rejection letter',
//         uuid: UUIDMaker.generateUUID(),
//         updatedAt: DateTime.now(),
//         createdAt: DateTime.now()),
//   ];

//   // add in the mock entries
//   for (JournalEntry entry in mockEntries) {
//     journalMocker.upsertEntry(entry);
//   }

//   return journalMocker;
// }
