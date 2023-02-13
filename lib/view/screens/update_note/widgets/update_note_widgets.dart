import 'package:flutter/material.dart';
import 'package:note_book/utils/extensions/widget_extensions.dart';
import 'package:note_book/utils/sizes/app_sizes.dart';
import 'package:note_book/utils/styles/text_style.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles/text_field_decorations.dart';

class UpdateNoteWidgets {
  BuildContext context;

  UpdateNoteWidgets({required this.context});

  Widget appBarView(bool isEnable, {required void Function()? onEyeClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _iconBgView(Icons.keyboard_arrow_left_sharp, onTap: () {
          finish(context);
        }),
        _iconBgView(
            isEnable ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
            onTap: onEyeClick),
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
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: keyBoardType,
        enabled: isEnabled,
        style: AppTextStyles.boldTextStyle(size: 30, txtColor: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText ?? "Enter title here.",
          hintStyle:
              AppTextStyles.boldTextStyle(size: 35, txtColor: Colors.grey),
          counterText: "",
          labelStyle: TextStyle(color: textColor),
          border: TextFieldBorders.textFieldBorder(),
          focusedBorder: TextFieldBorders.textFieldFocusBorder(),
          enabledBorder: TextFieldBorders.textFieldEnableBorder(),
          focusedErrorBorder: TextFieldBorders.textFieldErrorBorder(),
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
      height: height - 150.0,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        maxLines: height ~/ 20,
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: keyBoardType,
        enabled: isEnabled,
        style: AppTextStyles.normalTextStyle(txtColor: Colors.white, size: 16),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: hintText ?? "Enter title here.",
          counterText: "",
          hintStyle: const TextStyle(color: Colors.grey),
          border: TextFieldBorders.textFieldBorder(),
          focusedBorder: TextFieldBorders.textFieldFocusBorder(),
          enabledBorder: TextFieldBorders.textFieldEnableBorder(),
          focusedErrorBorder: TextFieldBorders.textFieldErrorBorder(),
        ),
      ).paddingSymmetric(vertical: 5, horizontal: 5),
    );
  }
}
