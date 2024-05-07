import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:journal/utils/uuid_maker.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Change this title if you want -- No, I'm ok
          title: const Text('All Journal Entries',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          // Added use of actions parameter here to make a button for adding a new entry.
          actions: <Widget>[
            Semantics(
              button: true,
              label: 'Add a new journal entry',
              hint: 'Tap to add a new entry',
              child: IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add a New Entry!',
                onPressed: () => _addNewEntry(context),
              ),
            )
          ],
        ),
        // Put a Consumer here, and make it's builder call ListView.builder.
        body: Consumer<JournalProvider>(builder: (context, provider, child) {
          // Used ListView.builder to create and show a scrollable view of all JournalEntries
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              return _createListElementForEntry(
                  context, provider.entries[index]);
            },
          );
        }));
  }

  // Defining _createListElementForEntry
  Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
    String formattedDate = DateFormat('MMMM d').format(entry.createdAt);
    String formattedTime = DateFormat('jm').format(entry.createdAt);

    return Semantics(
        container: true,
        label: 'Journal Entry from $formattedDate at $formattedTime',
        hint: 'Tap to view or edit the entry',
        child: Card(
          // margin: const EdgeInsets.all(10),
          color: const Color(0xFF651971),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          elevation: 5,
          child: ListTile(
            leading: const Icon(Icons.favorite, color: Colors.white),
            title: Center(
                child: Text(formattedDate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ))),
            subtitle: Center(
                child: Text(formattedTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ))),
            trailing: const Icon(Icons.favorite, color: Colors.white),
            onTap: () => _navigateToEntry(context, entry),
          ),
        ));
  }

  // Creates new JournalEntry, upserts -> journal, goes to EntryView
  Future<void> _addNewEntry(BuildContext context) async {
    final DateTime when = DateTime.now();

    final newEntry = JournalEntry(
      gratitudeText: '',
      highlightText: '',
      uuid: UUIDMaker.generateUUID(),
      createdAt: when,
      updatedAt: when,
    );

    _navigateToEntry(context, newEntry, isNew: true);
  }

  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry,
      {bool isNew = false}) async {
    final JournalEntry? updatedEntry = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryView(entry: entry)));

    // Explaining when/why this would be true:
    // Context might not mount if widget was taken out of the tree during navigation
    if (!context.mounted) return;

    // ONLY UPSERT IF:
    // Entry has been modified or
    //  if its a new entry with content
    if (updatedEntry != null &&
        (isNew &&
                (updatedEntry.gratitudeText.isNotEmpty ||
                    updatedEntry.highlightText.isNotEmpty) ||
            !isNew)) {
      // Getting a non-listening reference to JournalProvider
      Provider.of<JournalProvider>(context, listen: false)
          // Calling provider's upsert method with entry
          .upsertJournalEntry(updatedEntry);
    }
  }
}
