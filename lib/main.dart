import 'package:flutter/material.dart';
import 'package:journal/views/all_entries_view.dart';
// import 'package:journal/utils/journal_mocker.dart';
// import 'package:journal/models/journal.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final Journal journalMocker = makeMockData();

    return ChangeNotifierProvider(
      create: (_) => JournalProvider(),
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
