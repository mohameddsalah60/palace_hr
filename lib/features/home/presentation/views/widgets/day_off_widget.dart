import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class DayOffWidget extends StatelessWidget {
  const DayOffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Day off", style: AppTextStyles.fontWeight600Size16),
    );
  }
}
