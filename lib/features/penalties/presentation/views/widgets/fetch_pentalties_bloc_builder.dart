import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubit/fetch_pentalties_cubit.dart';
import 'no_penalties_widget.dart';
import 'penalties_sliver_list.dart';

class FetchPentaltiesBlocBuilder extends StatelessWidget {
  const FetchPentaltiesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPenaltiesCubit, FetchPentaltiesState>(
      builder: (context, state) {
        if (state is FetchPentaltiesLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is FetchPentaltiesSuccess) {
          final penalties = context.read<FetchPenaltiesCubit>().penalties;
          if (penalties.isEmpty) {
            return NoPenaltiesWidget();
          }

          return PenaltiesSliverList(penalties: penalties);
        }

        return NoPenaltiesWidget();
      },
    );
  }
}
