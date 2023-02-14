
import 'package:note_book/view/widgets/empty_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
import 'package:note_book/view/screens/search_note/widgets/search_note_widgets.dart';

import '../../../controllers/note_controller.dart';
import '../../../models/notes/note_model.dart';
import '../note_details/note_details_screen.dart';
import '../notes/widgets/notes_widgets.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  TextEditingController searchController = TextEditingController();

  late NoteController noteController;

  @override
  void initState() {
    super.initState();
    initProvider();
  }

  Future<void> initProvider() async {
    noteController = Provider.of<NoteController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var view = SearchNoteWidgets(context: context);
    return Scaffold(
      body: WillPopScope(onWillPop: _onBackPressed, child: Column(
        children: [
          30.height,
          _searchView(view),
          Expanded(child: _swipeToDeleteItemView())
        ],
      ).paddingSymmetric(horizontal: 10)),
    );
  }

  Future<bool>_onBackPressed()async{
    noteController.clearSearchedNotes();
    finish(context);
    return true;
  }

  _searchView(SearchNoteWidgets view) {
    return Row(
      children: [
        view.backButtonView(_onBackPressed),
        Expanded(child: view.noteTitleEditView(searchController,onChanged: (searchText){
          noteController.searchNoteByTitle(searchText);
          setState(() {});
        }))
      ],
    );
  }

  _swipeToDeleteItemView() {
    var view = NotesWidgets(context: context);
    return Consumer<NoteController>(
      builder: (BuildContext context, value, Widget? child) {
        List<NoteModel> data = value.searchNotes;
        return data.isNotEmpty?ListView.separated(
          itemCount: data.length,
          itemBuilder: (c, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              resizeDuration: const Duration(milliseconds: 200),
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
        ):const EmptyScreen(message: "Oops.. Not Found!",);
      },
    );
  }

  Future<void> _deleteNote(
      int id,
      ) async {
    await noteController.deleteNote(id: id);
  }
}
