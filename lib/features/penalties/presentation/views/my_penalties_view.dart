import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/di/getit_service_loacator.dart';
import 'package:palace_hr/features/penalties/domin/repo/penalties_repo.dart';
import 'package:palace_hr/features/penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import 'widgets/my_penalties_body.dart';

class MyPenaltiesView extends StatelessWidget {
  const MyPenaltiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchPenaltiesCubit(getIt<PenaltiesRepo>())..fetchPenalties(),
      child: Scaffold(
        backgroundColor: AppColors.wheitDark,
        body: SafeArea(child: MyPenaltiesBody()),
      ),
    );
  }
}
