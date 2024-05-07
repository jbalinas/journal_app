import 'journal_entry.dart';
import 'package:hive/hive.dart';

// Represents our JOURNAL
// Manages our journal entries
class Journal {
  // Hive storage for entries
  final Box<JournalEntry> _storage;

  // Private list of journal entries
  List<JournalEntry> _entries;

  // Initializes a journal with entries from Hive storage box
  Journal(this._storage) : _entries = _storage.values.toList();

  // Entries getter
  // Returns copy of list of entries to avoid direct modification
  List<JournalEntry> get entries => List.from(_entries);

  // Upserts journal using Hive via
  // modifying storage after updating local list
  void upsertEntry(JournalEntry entry) {
    // var index = _entries.indexWhere((e) => e.uuid == entry.uuid);
    // if (index == -1) {
    //   _entries.add(entry);
    // } else {
    //   _entries[index] = entry;
    // }
    _storage.put(entry.uuid, entry);
    _entries = _storage.values.toList();
  }

  // Clone creator
  // Makes clone of journal with new list of entries
  Journal clone() {
    return Journal(_storage).._entries = List.from(_entries);
  }
}
