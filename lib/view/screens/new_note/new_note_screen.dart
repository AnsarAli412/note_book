import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/styles/text_style.dart';
import 'package:note_book/view/screens/new_note/widgets/new_note_widgets.dart';

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

  bool _isTitleEnable = true;

  bool _isDesEnable = true;

  @override
  void initState() {
    _showMessage();
    super.initState();
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
    var view = NewNoteWidgets(context: context);
    return Scaffold(
      body: WillPopScope(
          onWillPop: _deleteEmptyRow,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            children: [
              view.appBarView(_isTitleEnable, onEyeClick: _onEyeClick,onBackPress: _deleteEmptyRow),
              view.noteTitleEditView(titleController, onChanged: (text) {
                _autoSaveNote();
              },
                  hintText: "Title",
                  keyBoardType: TextInputType.multiline,
                  isEnabled: _isTitleEnable),
              view.noteDescEditView(descController,
                  hintText: "Type something...",
                  keyBoardType: TextInputType.multiline, onChanged: (text) {
                _autoSaveNote();
              }, isEnabled: _isDesEnable),
            ],
          )),
    );
  }

  _onEyeClick() {
    setState(() {
      _isDesEnable = !_isDesEnable;
      _isTitleEnable = !_isTitleEnable;
    });
  }

  _autoSaveNote() async {
    var data = NoteModel(
        title: titleController.text, description: descController.text);
    await noteController.updateNote(data, id: widget.id);
  }

  Future<bool> _deleteEmptyRow() async {
    if (titleController.text.isEmpty && descController.text.isEmpty) {
      await noteController.deleteNote(id: widget.id);
    }
    return true;
  }
}
