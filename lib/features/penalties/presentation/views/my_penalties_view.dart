import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'widgets/my_penalties_body.dart';

class MyPenaltiesView extends StatelessWidget {
  const MyPenaltiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      body: SafeArea(child: MyPenaltiesBody()),
    );
  }
}
