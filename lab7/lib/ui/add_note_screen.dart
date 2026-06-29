import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab7/providers/note_provider.dart';
import 'package:lab7/data/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, this.note});

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        date: widget.note?.date ?? DateTime.now(),
      );
      // Use the provider to save the note
      final provider = Provider.of<NoteProvider>(context, listen: false);
      if (widget.note == null) {
        provider.addNote(note);
      } else {
        provider.updateNote(note);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.note?.title ?? "";
    _descriptionController.text = widget.note?.description ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note')
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Title'
                ),
                controller: _titleController,
                validator: (value) {
                  if (value == "") {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description'
                ),
                controller: _descriptionController,
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          child: const Icon(Icons.save)
      ),
    );
  }
}