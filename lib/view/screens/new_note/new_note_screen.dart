import 'package:flutter/material.dart';
import 'package:note_book/controllers/database_helper.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/view/screens/new_note/widgets/new_note_widgets.dart';

class NewNoteScreen extends StatelessWidget {
  final int id;

  NewNoteScreen({Key? key, required this.id}) : super(key: key);

  NoteController noteController = NoteController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var view = NewNoteWidgets(context: context);

    return Scaffold(
      appBar: view.appBarView(),
      body: WillPopScope(
          onWillPop: _deleteEmptyRow,
          child: ListView(
            children: [
              view.noteTitleEditView(titleController, onChanged: (text) {
                _autoSaveNote();
              }),
              view.noteDescEditView(descController,
                  hintText: "Write your story .....",
                  keyBoardType: TextInputType.multiline, onChanged: (text) {
                _autoSaveNote();
              }),
            ],
          )),
    );
  }

  _autoSaveNote() async {
    var data = NoteModel(
        title: titleController.text, description: descController.text);
    await noteController.updateNote(data, id: id);
  }

  Future<bool> _deleteEmptyRow() async {
    if (titleController.text.isEmpty || descController.text.isEmpty) {
      await noteController.deleteNote(id: id);
    }

    return true;
  }
}
