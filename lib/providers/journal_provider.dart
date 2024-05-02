import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final Journal _journal = Journal();

  // Clone getter for avoiding direct modification
  Journal get journal => _journal.clone();

  // Proxy for upserting journal entries
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry);
    notifyListeners();
  }
}
