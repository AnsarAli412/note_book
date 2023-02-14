import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
import 'package:note_book/view/screens/note_details/widgets/note_detials_widgets.dart';
import 'package:note_book/view/screens/update_note/update_note_screen.dart';
import 'package:provider/provider.dart';

import '../new_note/new_note_screen.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NoteModel data;
   const NoteDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {

  NoteController noteController = NoteController();

  @override
  Widget build(BuildContext context) {
    var view = NoteDetailsWidgets(context: context);
    return Scaffold(
      floatingActionButton: view.floatingButton(onPressed: (){
        UpdateNoteScreen(data: widget.data).launchWidget(context);
      }),
      body: Consumer<NoteController>(builder: (BuildContext context, value, Widget? child) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          children: [
            view.appBarView(onAddClick: createNewNote),
            10.height,
            view.titleView(value.noteData.title??"No title available"),
            5.height,
            view.descView(value.noteData.description??"No description available"),
          ],
        );
      },),
    );
  }

  Future<void> createNewNote() async {
    int? id = await noteController.createEmptyNote();
    if (!mounted) return;

    if (id != null) {
      NewNoteScreen(
        id: id,
      ).launchWidget(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Can't create new note."),
        backgroundColor: Colors.red,
      ));
    }
  }
}
