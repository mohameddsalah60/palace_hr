import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'widgets/requests_views_body.dart';

class RequestsViews extends StatelessWidget {
  const RequestsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      body: SafeArea(child: RequestsViewBody()),
    );
  }
}
