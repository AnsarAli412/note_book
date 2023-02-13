import 'package:flutter/material.dart';
import 'package:note_book/view/screens/update_note/widgets/update_note_widgets.dart';
import 'package:provider/provider.dart';
import '../../../controllers/note_controller.dart';
import '../../../models/notes/note_model.dart';

class UpdateNoteScreen extends StatefulWidget {
  final NoteModel data;
  const UpdateNoteScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
   NoteController noteController = NoteController();

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var controller = Provider.of<NoteController>(context,listen: false);
    titleController = TextEditingController(text: controller.noteData.title);
    descController = TextEditingController(text: controller.noteData.description);
  }

  @override
  Widget build(BuildContext context) {
    var view = UpdateNoteWidgets(context: context);
    return Scaffold(
      appBar: view.appBarView(),
      body: ListView(
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
      ),
    );
  }

  _autoSaveNote() async {
    var controller = Provider.of<NoteController>(context,listen: false);
    var data = NoteModel(
        title: titleController.text, description: descController.text);
    controller.getNoteData(title: titleController.text, desc: descController.text);
    await noteController.updateNote(data, id: widget.data.id??0);
  }
}
