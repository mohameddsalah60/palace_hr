import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_hr/features/settings/domin/repos/log_out_user_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.logOutUserRepo) : super(LogoutInitial());
  final LogOutUserRepo logOutUserRepo;
  Future<void> logoutUser() async {
    emit(LogoutLoading());
    final result = await logOutUserRepo.logoutUser();
    result.fold(
      (failure) {
        emit(LogoutFailure(message: failure.errMessage));
      },
      (_) {
        emit(LogoutSuccess());
      },
    );
  }
}
