import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String title,
  void Function()? onTap,
  List<Widget>? actions,
}) {
  return AppBar(
    actions: actions,
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(title, style: AppTextStyles.fontWeight600Size16),
    leading: GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.maybePop(context);
          },
      child: const Icon(Icons.arrow_back_ios_new, size: 22),
    ),
  );
}
