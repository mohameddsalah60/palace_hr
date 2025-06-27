import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/features/requests/presentation/fetch_requests_cubit/fetch_requests_cubit.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/views/widgets/custom_header_refresh.dart';
import 'request_user_item.dart';

class RequestsBlocContent extends StatelessWidget {
  const RequestsBlocContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchRequestsCubit, FetchRequestsState>(
      builder: (context, state) {
        if (state is FetchRequestsSuccess) {
          final requests = state.requests;

          return SmartRefresher(
            controller: context.read<FetchRequestsCubit>().refreshController,
            enablePullDown: true,
            header: const CustomHeaderRefresh(),
            onLoading: context.read<FetchRequestsCubit>().onLoading,
            onRefresh: context.read<FetchRequestsCubit>().onRefresh,
            child:
                requests.isEmpty
                    ? Center(child: Text(S.of(context).noRequestsMessage))
                    : CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: RequestUserItem(
                                requestUserInputEntity: requests[index],
                              ),
                            ),
                            childCount: requests.length,
                          ),
                        ),
                      ],
                    ),
          );
        } else if (state is FetchRequestsEmpty) {
          return const Center(child: Text("No requests found."));
        } else if (state is FetchRequestsFailure) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(state.message),
            ),
          );
        }

        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
