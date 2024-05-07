import 'package:flutter/material.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());

  // CREDIT:
  // From here to runApp is heavily pulled from
  //  documentation given in class spec below:
  //  https://docs.hivedb.dev/#/advanced/encrypted_box

  // FlutterSecureStorage instance
  const secureStorage = FlutterSecureStorage();

  // Encryption key exists check
  String? encryptionKeyString = await secureStorage.read(key: 'encryptionKey');
  if (encryptionKeyString == null) {
    // No key exists? Generate one.
    final key = Hive.generateSecureKey();
    // Encode new key + store securely in storage
    await secureStorage.write(
        key: 'encryptionKey', value: base64UrlEncode(key));
    // Local variable update
    encryptionKeyString = base64UrlEncode(key);
  }

  // Otherwise, we have a key!

  // Decode stored key
  final encryptionKey = base64Url.decode(encryptionKeyString);

  // Open encrypted Hive box
  final Box<JournalEntry> storage = await Hive.openBox<JournalEntry>(
      'encryptedJournalEntries',
      encryptionCipher: HiveAesCipher(encryptionKey));

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
        debugShowCheckedModeBanner: false, // to not block the + button
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: const AllEntriesView(),
      ),
    );
  }
}
