import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

Future<void> cutsomModalBottomSheet({
  required BuildContext context,
  Widget? child,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * .90,
          padding: EdgeInsets.all(16.r),
          decoration: const BoxDecoration(
            color: AppColors.wheitDark,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: PopModelBottomSheet()),
              child ?? SizedBox.shrink(),
            ],
          ),
        ),
      );
    },
  );
}

class PopModelBottomSheet extends StatelessWidget {
  const PopModelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (scroll) {
        if (scroll.delta.dy > 0) {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 5.h,
        width: 80.w,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
