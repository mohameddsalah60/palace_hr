import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/features/home/domin/repos/face_recognition_repo.dart';
import 'package:palace_hr/features/home/domin/repos/schedules_repo.dart';
import 'package:palace_hr/features/requests/presentation/fetch_requests_cubit/fetch_requests_cubit.dart';

import '../../../../core/di/getit_service_loacator.dart';
import '../../../penalties/domin/repo/penalties_repo.dart';
import '../../../penalties/presentation/cubits/cubit/fetch_pentalties_cubit.dart';
import '../../../penalties/presentation/views/my_penalties_view.dart';
import '../../../requests/domin/repo/request_repo.dart';
import '../../../requests/presentation/views/my_requests_views.dart';
import '../../domin/repos/home_repo.dart';
import '../cubits/cubit/home_cubit.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/home_view_body.dart';
import 'widgets/quick_selfie_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  late FetchPenaltiesCubit _penaltiesCubit;
  late FetchRequestsCubit _requestsCubit;

  @override
  void initState() {
    super.initState();
    quickSelfieDialog(context);
    _penaltiesCubit = FetchPenaltiesCubit(getIt<PenaltiesRepo>());
    _requestsCubit = FetchRequestsCubit(getIt<RequestRepo>());
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      _penaltiesCubit.penalties.isEmpty
          ? _penaltiesCubit.fetchPenalties()
          : null;
    } else if (index == 2) {
      _requestsCubit.requests.isEmpty
          ? _requestsCubit.fetchUserReqeusts()
          : null;
    }
  }

  @override
  void dispose() {
    _penaltiesCubit.close();
    _requestsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BlocProvider(
            create:
                (context) => HomeCubit(
                  getIt<HomeRepo>(),
                  getIt<FaceRecognitionRepo>(),
                  getIt<SchedulesRepo>(),
                )..loadUserSchedules(),
            child: HomeViewBody(),
          ),
          BlocProvider.value(value: _penaltiesCubit, child: MyPenaltiesView()),
          BlocProvider.value(value: _requestsCubit, child: RequestsViews()),
        ],
      ),
    );
  }
}
