import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../home/presentation/views/widgets/custom_header_refresh.dart';
import '../../../domin/entites/penalty_entity.dart';
import '../../cubits/cubit/fetch_pentalties_cubit.dart';
import 'my_penalty_item.dart';

class PenaltiesSliverList extends StatelessWidget {
  const PenaltiesSliverList({super.key, required this.penalties});
  final List<PenaltyEntity> penalties;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: context.read<FetchPenaltiesCubit>().refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: context.read<FetchPenaltiesCubit>().onRefresh,
        onLoading: context.read<FetchPenaltiesCubit>().onLoading,
        header: const CustomHeaderRefresh(),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final penalty = penalties[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: PenaltyItem(
                    title: penalty.title,
                    date:
                        "${penalty.date.year}-${penalty.date.month}-${penalty.date.day}",
                    description: penalty.description,
                    penaltyValue: penalty.value,
                  ),
                );
              }, childCount: penalties.length),
            ),
          ],
        ),
      ),
    );
  }
}
