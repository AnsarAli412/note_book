import 'package:flutter/material.dart';
import 'package:note_book/controllers/note_controller.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/colors.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
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
      body: RefreshIndicator(
          child: _mainView(view), onRefresh: getNotes, color: iconBgColor),
    );
  }

  _mainView(NotesWidgets view) {
    return Column(
      children: [
        view.appBarView(onHelpClick: getNotes),
        Expanded(child: _swipeToDeleteItemView(view))
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 30);
  }

  _swipeToDeleteItemView(NotesWidgets view) {
    return Consumer<NoteController>(
      builder: (BuildContext context, value, Widget? child) {
        List<NoteModel> data = value.notes;
        return data.isNotEmpty?ListView.separated(
          itemCount: data.length,
          itemBuilder: (c, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              resizeDuration: Duration(milliseconds: 200),
              key: ObjectKey(data.elementAt(index)),
              onDismissed: (direction) {
                _deleteNote(data[index].id ?? 0).then((value) {
                  setState(() {
                    data.removeAt(index);
                  });
                });
              },
              background: Container(
                padding: const EdgeInsets.only(left: 28.0),
                alignment: AlignmentDirectional.center,
                color: Colors.red,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
              // secondaryBackground: ...,
              child: view.listItemView(index, data: data[index], onTap: () {
                noteController.getNoteData(
                    title: data[index].title ?? "",
                    desc: data[index].description ?? "");
                NoteDetailsScreen(data: data[index]).launchWidget(context);
              }),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return 10.height;
          },
        ):view.noNoteView();
      },
    );
  }

  Future<void> _deleteNote(
    int id,
  ) async {
    await noteController.deleteNote(id: id);
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
