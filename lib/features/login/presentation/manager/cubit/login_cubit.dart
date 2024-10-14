import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/features/login/data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  final LoginRepo loginRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey();
  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;

    emit(LoginLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await loginRepo.login(
        userName: emailController.text, password: passwordController.text);
    result.fold((failure) {
      isLoading = false;
      emit(
        LoginError(errMessage: failure.errMessage),
      );
    }, (userResponse) {
      log(userResponse.accessToken);
      prefs.setString('token', userResponse.accessToken);
      prefs.setInt('userId', userResponse.id);
      isLoading = false;
      emit(LoginSuccess());
    });
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void loginValidate() {
    if (loginKey.currentState!.validate()) {
      login();
    }
  }

  void closeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Future<void> close() {
    closeControllers();
    return super.close();
  }
}
