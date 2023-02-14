import 'package:flutter/material.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'package:note_book/utils/extensions/date_time_extensions.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
import 'package:note_book/utils/styles/text_style.dart';
import 'package:note_book/view/screens/search_note/search_note_screen.dart';

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
              const SearchNoteScreen().launchWidget(context);
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

  Widget listItemView(int index,
      {required NoteModel data, void Function()? onTap}) {
    var width = screenWidth(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: width,
        color: Colors.primaries[index % Colors.primaries.length].shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title ?? "",
              style: AppTextStyles.boldTextStyle(size: 24),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              data.description ?? "",
              style: AppTextStyles.normalTextStyle(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            5.height,
            _dateAndTimeView(data.updatedAt ?? DateTime.now())
          ],
        ),
      ).cornerRadiusWithClipRRect(6),
    );
  }

  Widget _dateAndTimeView(DateTime dateTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dateTime.getToday(),
          style:
              AppTextStyles.normalTextStyle(txtColor: Colors.white, size: 10),
        ),
        Text(
          dateTime.getTimeIn12Hours(),
          style:
              AppTextStyles.normalTextStyle(txtColor: Colors.white, size: 10),
        )
      ],
    );
  }

  Widget noNoteView({String? imagePath}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath ?? "assets/images/empty_note.png"),
        Text(
          "Create your first note !",
          style:
              AppTextStyles.normalTextStyle(txtColor: Colors.white, size: 14),
        )
      ],
    );
  }
}
