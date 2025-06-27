import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fetch_pentalties_bloc_builder.dart';
import 'my_penalties_header.dart';

class MyPenaltiesBody extends StatelessWidget {
  const MyPenaltiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyPenaltiesHeader(),
          SizedBox(height: 24.h),
          FetchPentaltiesBlocBuilder(),
        ],
      ),
    );
  }
}
