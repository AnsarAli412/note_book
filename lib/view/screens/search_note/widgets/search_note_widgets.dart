import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles/text_field_decorations.dart';
import '../../../../utils/styles/text_style.dart';

class SearchNoteWidgets{
  BuildContext context;

  SearchNoteWidgets({required this.context});



  Widget backButtonView(Function() onBackPressed) {
    return InkWell(
      onTap: onBackPressed,
      child: Container(
        height: 35,
        width: 35,
        color: iconBgColor,
        child: const Icon(Icons.keyboard_arrow_left),
      ),
    ).cornerRadiusWithClipRRect(6).paddingAll(6);
  }

  Widget noteTitleEditView(TextEditingController controller,
      {String? hintText,
        int? maxLines,
        String? Function(String?)? validator,
        TextInputType keyBoardType = TextInputType.text,
        bool isEnabled = true,
        void Function(String)? onChanged}) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: keyBoardType,
        enabled: isEnabled,
        autofocus: false,
        style: AppTextStyles.normalTextStyle(size: 14, txtColor: Colors.white),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search,color: Colors.white,),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText ?? "Search notes...",
          hintStyle:
          AppTextStyles.normalTextStyle(size: 14, txtColor: Colors.grey),
          counterText: "",
          labelStyle: TextStyle(color: textColor),
          border: TextFieldBorders.textFieldBorder(borderColor: iconBgColor,borderRadius: 30),
          focusedBorder: TextFieldBorders.textFieldFocusBorder(borderColor: Colors.white,borderRadius: 30),
          enabledBorder: TextFieldBorders.textFieldEnableBorder(borderColor: iconBgColor,borderRadius: 30),
          disabledBorder: TextFieldBorders.textFieldBorder(borderColor: iconBgColor,borderRadius: 30),
          focusedErrorBorder: TextFieldBorders.textFieldErrorBorder(borderColor: iconBgColor,borderRadius: 30),
        ),
      ).paddingSymmetric(vertical: 5, horizontal: 5),
    );
  }
}