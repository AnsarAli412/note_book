import 'package:flutter/material.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
import 'package:note_book/utils/sizes/border_radius.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles/text_field_decorations.dart';

class NewNoteWidgets {
  BuildContext context;

  NewNoteWidgets({required this.context});

  AppBar appBarView({String? title}) => AppBar(
        title: Text(title ?? "New Note"),
      );

  Widget noteTitleEditView(TextEditingController controller,
      {String? hintText,
      int? maxLines,
      String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,
      bool isEnabled = true,
      void Function(String)? onChanged}) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        maxLines: null,
        cursorColor: textColor,
        controller: controller,
        keyboardType: keyBoardType,
        enabled: isEnabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText ?? "Enter title here.",
          counterText: "",
          labelStyle: TextStyle(color: textColor),
        ),
      ).paddingSymmetric(vertical: 5, horizontal: 5),
    );
  }

  Widget noteDescEditView(TextEditingController controller,
      {String? hintText,
      int? maxLines,
      String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,
      bool isEnabled = true,
      void Function(String)? onChanged}) {
    var height = screenHeight(context);
    return SizedBox(
      height: height -150.0,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
         maxLines: height ~/ 20,
        cursorColor: textColor,
        controller: controller,
        keyboardType: keyBoardType,
        enabled: isEnabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          hintText: hintText ?? "Enter title here.",
          counterText: "",
          labelStyle: TextStyle(color: textColor),
          border: TextFieldBorders.textFieldBorder(),
           focusedBorder: TextFieldBorders.textFieldFocusBorder(),
          // errorBorder: TextFieldBorders.textFieldErrorBorder(),
          // disabledBorder: TextFieldBorders.textFieldBorder(),
          enabledBorder: _border(),
           focusedErrorBorder: TextFieldBorders.textFieldErrorBorder(),
        ),
      ).paddingSymmetric(vertical: 5, horizontal: 5),
    );
  }

  _border(){
    return OutlineInputBorder(
        borderRadius: circularBorderRadius(
          borderRadius: 2,
        ),
        borderSide: BorderSide(width: 2, color: mainColor));
  }
}
