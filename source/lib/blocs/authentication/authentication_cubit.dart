import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.loading);

  Future<void> onCheck() async {
    emit(AuthenticationState.loading);

    UserModel? user = await AppBloc.userCubit.onLoadUser();

    if (user != null) {
      final result = await UserRepository.validateToken();
      if (result) {
        emit(AuthenticationState.success);
      } else {
        emit(AuthenticationState.fail);
      }
    } else {
      emit(AuthenticationState.fail);
    }
  }

  Future<void> onSave(UserModel user) async {
    emit(AuthenticationState.loading);
    await AppBloc.userCubit.onSaveUser(user);
    AppBloc.wishListCubit.onLoad();
    emit(AuthenticationState.success);
  }

  void onClear() {
    emit(AuthenticationState.fail);
    AppBloc.userCubit.onDeleteUser();
  }

  Future<bool> requestOTP(String email) async {
    emit(AuthenticationState.loading);
    final result = await UserRepository.requestOTP(email);
    if (result) {
      emit(AuthenticationState.otpRequested);
      return true;
    } else {
      emit(AuthenticationState.otpRequestFailed);
      return false;
    }
  }

  Future<bool> verifyOTP(String email, String otp) async {
    emit(AuthenticationState.loading);
    final result = await UserRepository.verifyOTP(email, otp);
    if (result) {
      emit(AuthenticationState.otpVerified);
      return true;
    } else {
      emit(AuthenticationState.otpVerificationFailed);
      return false;
    }
  }
}

