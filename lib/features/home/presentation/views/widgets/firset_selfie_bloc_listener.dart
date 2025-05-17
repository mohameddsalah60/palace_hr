import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/helpers/extinctions.dart';
import 'package:palace_hr/features/home/presentation/cubits/firset_selfie_cubit/firset_selfie_cubit.dart';
import 'package:palace_hr/features/home/presentation/views/widgets/quick_selfie_dialog.dart';

import '../../../../../core/widgets/custom_error_dialog.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../generated/l10n.dart';

class FirsetSelfieBlocListener extends StatelessWidget {
  const FirsetSelfieBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FirsetSelfieCubit, FirsetSelfieState>(
      listener: (context, state) {
        if (state is FirsetSelfieFailure) {
          context.pop();

          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withValues(alpha: 0.3),
            builder:
                (context) => CustomErrorDialog(
                  message: state.message,
                  onPressed: () {
                    context.pop();
                    quickSelfieDialog(context);
                  },
                ),
          );
        } else if (state is FirsetSelfieSuccess) {
          context.pop();
          customSnackBar(
            context: context,
            message: S.of(context).uploadedImage,
            color: Colors.green,
          );
        }
      },
      child: child,
    );
  }
}
