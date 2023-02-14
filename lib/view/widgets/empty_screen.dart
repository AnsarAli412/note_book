import 'package:flutter/material.dart';

import '../../utils/sizes/app_sizes.dart';
import '../../utils/styles/text_style.dart';

class EmptyScreen extends StatelessWidget {
  final String? imagePath;
  final String? message;

  const EmptyScreen({Key? key, this.imagePath, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = screenWidth(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath ?? "assets/images/not_found_note.png",
              width: width / 1.5,
              fit: BoxFit.contain,
            ),
            10.height,
            Text(
              message ?? "Create your first note !",
              style: AppTextStyles.normalTextStyle(
                  txtColor: Colors.white, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
