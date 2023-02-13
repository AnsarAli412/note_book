import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/view/screens/new_note/new_note_screen.dart';
import 'package:note_book/view/screens/note_details/note_details_screen.dart';
import 'package:note_book/view/screens/notes/widgets/notes_widgets.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NoteController noteController;

  var isSelected = false;
  var tileColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<void> getNotes() async {
    noteController = Provider.of<NoteController>(context, listen: false);
    noteController.getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    var view = NotesWidgets(context: context);
    return Scaffold(
      floatingActionButton: view.floatButton(onPressed: createNewNote),
      appBar: view.noteAppBarView(),
      body: RefreshIndicator(child: _mainView(view), onRefresh: getNotes),
    );
  }

  _mainView(NotesWidgets view) {
    return Consumer<NoteController>(builder: (c, value, child) {
      List<NoteModel> data = value.notes;
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (c, index) {
            return view.listItemView(
              isSelected: isSelected,
                data: data[index],
                onLongPress: _onLongPressed,
                onTap: () {
                  noteController.getNoteData(
                      title: data[index].title ?? "",
                      desc: data[index].description ?? "");
                  NoteDetailsScreen(data: data[index]).launchWidget(context);
                });
          });
    });
  }

  _onLongPressed(){
    setState(() {
      if (isSelected) {
        tileColor =Colors.white;
        isSelected = false;
      } else {
        tileColor =Colors.grey.withOpacity(.5);
        isSelected = true;
      }
    });
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
