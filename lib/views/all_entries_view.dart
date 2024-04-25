import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO(optional): Change this title if you want
        title: const Text('All Journal Entries'),
        // TODO(required): Add use of actions parameter here to make a button for adding a new entry. 
      ),
      body: const Column(
        children: <Widget>[
          Expanded(
            // TODO(required): Use ListView.builder to create and show a scrollable view of all JournalEntries
            // TODO(required): Put a Consumer here, and make it's builder call ListView.builder. 
            //  Once you do that, you should remove all references to the journal field that holds mock data
            child: Placeholder()
          )
        ],
      ),
    );
  }

  // TODO(required): define _createListElementForEntry


  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EntryView(entry: entry))
    );

    if (!context.mounted) return; // TODO(required): Add comment here explaining when/why this would be true

    // TODO(required): Get non-listening reference to JournalProvider
    // TODO(required): Call provider's upsert method with entry

  }

  _formatDateTime(DateTime when){
    // TODO(optional): Change this format if you want. 
    //  Remove this `TODO` if you don't want to do it.
    //  Explain your changes in README if you do change.
    return DateFormat.yMd().add_jm().format(when);
  }

}