import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  // TextEditingController to link with TextField
  // Since I have more than one text field I want to use
  // documentation in README
  late TextEditingController gratitudeTextController;
  late TextEditingController highlightTextController;

  @override
  void initState() {
    super.initState();
    gratitudeTextController =
        TextEditingController(text: widget.entry.gratitudeText);
    highlightTextController =
        TextEditingController(text: widget.entry.highlightText);
  }

  // UI for entering entry into journal via answering each prompt with text
  // Should be able to successfully:
  // go back, write or edit an entry, save
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Journal Entry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                )),
            actions: [
              Semantics(
                  button: true,
                  label: 'Save the journal entry',
                  hint: 'Tap to save the journal entry',
                  child: IconButton(
                    icon: const Icon(Icons.save),
                    tooltip: 'Save Entry',
                    onPressed: () => _popBack(context),
                  ))
            ]),
        body: PopScope(
            onPopInvoked: (didPop) async {
              if (!didPop) {
                // Intercept back button to save before popping
                await _popBack(context);
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildCard(
                      'What are you grateful for today?',
                      gratitudeTextController,
                    ),
                    _buildCard(
                      'What was the highlight of your day?',
                      highlightTextController,
                    ),
                  ],
                ))));
  }

  // Widget for making our text entry experience more smooth and pretty
  Widget _buildCard(String labelText, TextEditingController controller) {
    return Semantics(
        container: true,
        label: '$labelText, text field',
        child: Card(
          color: const Color(0xFF651971),
          margin: const EdgeInsets.all(8),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
                controller: controller,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  fillColor: const Color(0xFF651971),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                )),
          ),
        ));
  }

  _popBack(BuildContext context) {
    // A new JournalEntry with our text updates
    JournalEntry updatedEntry = JournalEntry(
      gratitudeText: gratitudeTextController.text,
      highlightText: highlightTextController.text,
      uuid: widget.entry.uuid,
      createdAt: widget.entry.createdAt,
      updatedAt: DateTime.now(),
    );

    // call Navigator.pop with it (and context)
    Navigator.pop(context, updatedEntry);
  }
}
