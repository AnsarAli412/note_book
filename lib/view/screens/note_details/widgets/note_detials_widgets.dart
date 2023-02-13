import 'package:flutter/material.dart';
import 'package:note_book/utils/styles/text_style.dart';

class NoteDetailsWidgets{
  BuildContext context;
  NoteDetailsWidgets({required this.context});

  AppBar appBarView()=>AppBar(title: const Text("Note Details"),);
  Widget titleView(String title) => Text(title,style: AppTextStyles.boldTextStyle(),);
  Widget descView(String title) => Text(title,style: AppTextStyles.normalTextStyle(size: 14),);

  Widget floatingButton({required void Function()? onPressed}){
    return FloatingActionButton(onPressed: onPressed,child: const Icon(Icons.edit),);
  }
}