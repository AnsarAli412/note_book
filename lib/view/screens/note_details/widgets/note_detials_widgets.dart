import 'package:flutter/material.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/styles/text_style.dart';

import '../../../../utils/colors.dart';

class NoteDetailsWidgets{
  BuildContext context;
  NoteDetailsWidgets({required this.context});

  Widget appBarView({required void Function()? onAddClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _iconBgView(Icons.keyboard_arrow_left_sharp, onTap: () {
          finish(context);
        }),
        _iconBgView(
            Icons.add,
            onTap: onAddClick),
      ],
    );
  }

  _iconBgView(IconData icon, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        color: iconBgColor,
        child: Icon(icon),
      ),
    ).cornerRadiusWithClipRRect(6).paddingAll(6);
  }

  Widget titleView(String title) => Text(title,style: AppTextStyles.boldTextStyle(txtColor: Colors.white,size: 30),);
  Widget descView(String title) => Text(title,style: AppTextStyles.normalTextStyle(size: 14,txtColor: Colors.white,),);

  Widget floatingButton({required void Function()? onPressed}){
    return FloatingActionButton(onPressed: onPressed,child: const Icon(Icons.edit),);
  }
}