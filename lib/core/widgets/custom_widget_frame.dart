import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

class StyledWidgetFrame extends StatelessWidget {
  const StyledWidgetFrame({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.bkColor,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bkColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16),
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      decoration: ShapeDecoration(
        color: bkColor ?? AppColors.wheit,
        shadows: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Color(0x19000000),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      child: child,
    );
  }
}
