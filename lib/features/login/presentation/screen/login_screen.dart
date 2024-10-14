import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/core/service_locator.dart';
import 'package:taskes/core/widget/custom_main_app_bar.dart';
import 'package:taskes/features/login/data/repo/login_repo_impl.dart';
import 'package:taskes/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:taskes/features/login/presentation/screen/widget/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child:const  CustomMainAppBar(title: 'Login',),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(locator<LoginRepoImpl>()),
        child: const LoginScreenBody(),
      ),
    );
  }
}
