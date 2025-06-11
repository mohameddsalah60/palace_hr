import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/features/penalties/domin/entites/penalty_entity.dart';
import 'package:palace_hr/features/penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';

import 'my_penalties_header.dart';
import 'my_penalty_item.dart';

class MyPenaltiesBody extends StatelessWidget {
  const MyPenaltiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [MyPenaltiesHeader(), SizedBox(height: 24.h)],
            ),
          ),

          /// ✅ BlocBuilder بيبني Slivers مباشرة
          BlocBuilder<FetchPenaltiesCubit, FetchPentaltiesState>(
            builder: (context, state) {
              if (state is FetchPentaltiesSuccess) {
                return PenaltiesSliverList(penalties: state.penalties);
              }

              // لو فاضي أو لسه بيجيب
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

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
