import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/view/screens/note_details/widgets/note_detials_widgets.dart';
import 'package:note_book/view/screens/update_note/update_note_screen.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NoteModel data;
   const NoteDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var view = NoteDetailsWidgets(context: context);
    return Scaffold(
      appBar: view.appBarView(),
      floatingActionButton: view.floatingButton(onPressed: (){
        UpdateNoteScreen(data: data).launchWidget(context);
      }),
      body: Consumer<NoteController>(builder: (BuildContext context, value, Widget? child) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          children: [
            view.titleView(value.noteData.title??"No title available"),
            const Divider(thickness: 1,),
            view.descView(value.noteData.description??"No description available"),
          ],
        );
      },),
    );
  }

}
