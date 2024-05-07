import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final Journal _journal;

  JournalProvider({required Journal journal}) : _journal = journal;

  // // Clone getter for avoiding direct modification
  // Journal get journal => _journal.clone();

  // Need to indirectly expose journal entries
  List<JournalEntry> get entries => _journal.entries;

  // Proxy for upserting journal entries
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry);
    notifyListeners();
  }
}
