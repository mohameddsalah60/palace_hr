import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palace_hr/features/penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';
import 'package:palace_hr/generated/l10n.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_month_date_picker.dart';

class MyPenaltiesHeader extends StatelessWidget {
  const MyPenaltiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        S.of(context).mypenalties,
        style: AppTextStyles.fontWeight700Size16,
      ),
      trailing: GestureDetector(
        onTap: () async {
          DateTime? time = await customMonthYearPicker(context);
          if (time != null) {
            if (context.mounted) {
              context.read<FetchPenaltiesCubit>().fetchPenalties(sort: time);
            }
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.wheit,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Icon(FontAwesomeIcons.calendar),
        ),
      ),
    );
  }
}
