import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domin/entites/penalty_entity.dart';
import 'my_penalty_item.dart';

class PenaltiesSliverList extends StatelessWidget {
  const PenaltiesSliverList({super.key, required this.penalties});
  final List<PenaltyEntity> penalties;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: PenaltyItem(
            title: penalties[index].title,
            date:
                "${penalties[index].date.year}-${penalties[index].date.month}-${penalties[index].date.day}",
            description: penalties[index].description,
            penaltyValue: penalties[index].value,
          ),
        ),
        childCount: penalties.length,
      ),
    );
  }
}
