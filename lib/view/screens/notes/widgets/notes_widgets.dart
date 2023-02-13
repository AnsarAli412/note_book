import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/shapes/app_shapes.dart';

import '../../new_note/new_note_screen.dart';


class NotesWidgets {
  BuildContext context;

  NotesWidgets({required this.context});

  AppBar noteAppBarView() => AppBar(
        title: const Text("Notes"),
      );

  Widget floatButton({required void Function()? onPressed}){
    return FloatingActionButton(onPressed: onPressed,child: const Icon(Icons.note_alt_outlined),);
  }

  Widget listItemView({required NoteModel data,void Function()? onTap,void Function()? onLongPress,bool isSelected = false}) {
    return Card(
      shape: circularBorderShape(),
      child: ListTile(
        key: Key(data.id.toString()),
        onTap: onTap,
        selected: isSelected,
        onLongPress: onLongPress,
        title: Text(data.title??""),
        subtitle: Text(data.description??""),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
        ),
        leading: const Icon(CupertinoIcons.doc,size: 30,),
      ),
    );
  }

}
