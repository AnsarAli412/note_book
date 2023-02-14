import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/styles/text_style.dart';
import 'package:note_book/view/screens/new_note/widgets/new_note_widgets.dart';
import 'package:intl/intl.dart';

class NewNoteScreen extends StatefulWidget {
  final int id;

  const NewNoteScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  NoteController noteController = NoteController();

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  bool _isEditable = true;

  @override
  void initState() {
    _showMessage();
    super.initState();
  }

  _showMessage() {
    if(!mounted) return;
    Future.delayed(const Duration(seconds: 3),(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Auto save enabled",
            style: AppTextStyles.normalTextStyle(txtColor: Colors.green, size: 16),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    var view = NewNoteWidgets(context: context);
    return Scaffold(
      body: WillPopScope(
          onWillPop: _deleteEmptyRow,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            children: [
              view.appBarView(_isEditable, onEyeClick: _onEyeClick,onBackPress: (){
                _deleteEmptyRow();
              }),
              view.noteTitleEditView(titleController, onChanged: (text) {
                _autoSaveNote();
              },
                  hintText: "Title",
                  keyBoardType: TextInputType.multiline,
                  isEnabled: _isEditable),
              view.noteDescEditView(descController,
                  hintText: "Type something...",
                  keyBoardType: TextInputType.multiline, onChanged: (text) {
                _autoSaveNote();
              }, isEnabled: _isEditable),
            ],
          )),
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
    var data = NoteModel(
        title: titleController.text, description: descController.text,updatedAt: DateTime.parse(currentDateTime));
    await noteController.updateNote(data, id: widget.id);
  }

  Future<bool> _deleteEmptyRow() async {
    if (titleController.text.isEmpty && descController.text.isEmpty) {
      await noteController.deleteNote(id: widget.id).then((value){
        finish(context);
      });
    }else{
      finish(context);
    }
    return true;
  }
}
