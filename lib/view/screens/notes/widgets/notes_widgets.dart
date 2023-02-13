import 'package:flutter/material.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/shapes/app_shapes.dart';
import 'package:note_book/utils/styles/text_style.dart';

import '../../../../utils/colors.dart';

class NotesWidgets {
  BuildContext context;
  NotesWidgets({required this.context});

  Widget appBarView({required void Function()? onHelpClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _titleTextView(),
        Row(
          children: [
            _iconBgView(Icons.search, onTap: () {
              finish(context);
            }),
            _iconBgView(Icons.refresh, onTap: onHelpClick),
          ],
        )
      ],
    );
  }

  _titleTextView() {
    return Text(
      "Notes",
      style: AppTextStyles.boldTextStyle(size: 30, txtColor: Colors.white),
    );
  }

  _iconBgView(IconData icon, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        color: iconBgColor,
        child: Icon(
          icon,
          size: 18,
        ),
      ),
    ).cornerRadiusWithClipRRect(6).paddingAll(6);
  }

  Widget floatButton({required void Function()? onPressed}) {
    return FloatingActionButton(
      elevation: 10,
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  Widget listItemView(int index,{required NoteModel data, void Function()? onTap}) {
    return ListTile(
      tileColor: Colors.primaries[index % Colors.primaries.length].shade300,
      shape: circularBorderShape(borderColor: Colors.transparent),
      onTap: onTap,
      title: Text(
        data.title ?? "",
        style: AppTextStyles.boldTextStyle(size: 24),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.description ?? "",
        style: AppTextStyles.normalTextStyle(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget noNoteView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_note.png"),
        Text("Create your first note !",style: AppTextStyles.normalTextStyle(txtColor: Colors.white,size: 14),)
      ],
    );
  }
}
