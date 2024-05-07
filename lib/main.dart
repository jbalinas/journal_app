import 'package:flutter/material.dart';
import 'package:journal/views/all_entries_view.dart';
// import 'package:journal/utils/journal_mocker.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journal/models/journal_entry.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());
  final Box<JournalEntry> storage =
      await Hive.openBox<JournalEntry>('journalEntries');
  runApp(MyApp(storage: storage));
}

class MyApp extends StatelessWidget {
  final Box<JournalEntry> storage;
  const MyApp({super.key, required this.storage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final Journal journalMocker = makeMockData();

    return ChangeNotifierProvider(
      create: (_) => JournalProvider(journal: Journal(storage)),
      child: MaterialApp(
        title: 'Journal App',
        debugShowCheckedModeBanner: false, // to not block the + buttong
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: const AllEntriesView(),
      ),
    );
  }
}
