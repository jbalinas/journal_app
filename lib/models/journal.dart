import 'journal_entry.dart';

// Represents our JOURNAL
// Manages our journal entries
class Journal {
  // Private list of journal entries
  List<JournalEntry> _entries;

  // Initializes a new journal with empty list of entries
  Journal() : _entries = [];

  // Entries getter
  // Returns copy of list of entries to avoid direct modification
  List<JournalEntry> get entries => List.from(_entries);

  // Upserts journal based on uuid
  // If entry !exist, it is added; if exist, it is updated
  void upsertEntry(JournalEntry entry) {
    var index = _entries.indexWhere((e) => e.uuid == entry.uuid);
    if (index == -1) {
      _entries.add(entry);
    } else {
      _entries[index] = entry;
    }
  }

  // Clone creator
  // Makes clone of journal with new list of entries
  Journal clone() {
    return Journal().._entries = List.from(_entries);
  }
}
