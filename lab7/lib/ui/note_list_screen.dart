import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab7/providers/note_provider.dart';
import 'package:lab7/ui/add_note_screen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(title: const Text('User Profile')),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        title: const Text('Notes'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.notes.isEmpty) {
            return const Center(
              child: Text('No notes yet. Tap + to add one!'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];
                return Card(
                  // ... UI for the note card
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text('${note.description}${note.description == "" ? "" : ' - '}${DateFormat.yMMMMd().format(note.date)}'),
                    trailing: SizedBox(
                      width: 96,
                      height: .maxFinite,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNoteScreen(note: note),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Call the provider to delete the note
                              Provider.of<NoteProvider>(context, listen: false)
                                  .deleteNote(note.id!);
                            },
                          )
                        ],
                      )
                    )
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
      ),
    );
  }
}