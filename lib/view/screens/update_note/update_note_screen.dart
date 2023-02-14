import 'package:flutter/material.dart';
import 'package:note_book/view/screens/update_note/widgets/update_note_widgets.dart';
import 'package:provider/provider.dart';
import '../../../controllers/note_controller.dart';
import '../../../models/notes/note_model.dart';
import '../../../utils/styles/text_style.dart';
import 'package:intl/intl.dart';

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

   bool _isEditable = true;

  @override
  void initState() {
    super.initState();
    var controller = Provider.of<NoteController>(context,listen: false);
    titleController = TextEditingController(text: controller.noteData.title);
    descController = TextEditingController(text: controller.noteData.description);
    _showMessage();
  }

   _showMessage() {
     Future.delayed(const Duration(seconds: 5),(){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text(
             "Auto save enabled",
             style: AppTextStyles.normalTextStyle(txtColor: Colors.green, size: 16),
           )));
     });
   }

  @override
  Widget build(BuildContext context) {
    var view = UpdateNoteWidgets(context: context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
        children: [
          view.appBarView(_isEditable, onEyeClick: _onEyeClick),
          view.noteTitleEditView(titleController, onChanged: (text) {
            _autoSaveNote();
          },isEnabled: _isEditable),
          view.noteDescEditView(descController,
              hintText: "Write your story .....",
              keyBoardType: TextInputType.multiline, onChanged: (text) {
                _autoSaveNote();
              },isEnabled: _isEditable),
        ],
      ),
    );
  }

   _onEyeClick() {
     setState(() {
       _isEditable = !_isEditable;
     });
   }

  _autoSaveNote() async {
    var now = DateTime.now();
    var currentDateTime = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
    var controller = Provider.of<NoteController>(context,listen: false);
    var data = NoteModel(
        title: titleController.text, description: descController.text,updatedAt: DateTime.parse(currentDateTime));
    controller.getNoteData(title: titleController.text, desc: descController.text);
    await noteController.updateNote(data, id: widget.data.id??0);
  }
}
