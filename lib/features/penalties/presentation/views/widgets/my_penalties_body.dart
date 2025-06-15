import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/features/penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';

import 'my_penalties_header.dart';
import 'no_penalties_widget.dart';
import 'penalties_sliver_list.dart';

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

          FetchPentaltiesBlocBuilder(),
        ],
      ),
    );
  }
}

class FetchPentaltiesBlocBuilder extends StatelessWidget {
  const FetchPentaltiesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPenaltiesCubit, FetchPentaltiesState>(
      builder: (context, state) {
        if (state is FetchPentaltiesSuccess) {
          if (state.penalties.isNotEmpty) {
            return PenaltiesSliverList(penalties: state.penalties);
          }
        } else if (state is FetchPentaltiesLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return NoPenaltiesWidget();
      },
    );
  }
}
