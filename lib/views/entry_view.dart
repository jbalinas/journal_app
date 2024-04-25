import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  String currentText = '';

  @override
  void initState() {
    super.initState();
    currentText = widget.entry.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entry'),
      ),
      body: const Placeholder(),
    );
  }

  _popBack(BuildContext context){
    // TODO(required): make a new JournalEntry with currentText (and/or other editable fields) and 
    // call Navigator.pop with it (and context)
  }

}

