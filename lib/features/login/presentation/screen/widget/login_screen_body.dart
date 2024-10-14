import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskes/core/assets.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/core/functions/custom_snack_bar.dart';
import 'package:taskes/core/widget/custom_base_container_app.dart';
import 'package:taskes/core/widget/custom_button.dart';
import 'package:taskes/core/widget/custom_textfield.dart';
import 'package:taskes/features/home/presentation/screens/home_screen.dart';
import 'package:taskes/features/login/presentation/manager/cubit/login_cubit.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSnackBar(context, 'Login Successful', true);
          GoRouter.of(context).pushReplacement(HomeScreen.routeName);
        } else if (state is LoginError) {
          showSnackBar(context, state.errMessage, false);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Main content
            CustomBaseContainerApp(
              widget: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  child: Form(
                    key: LoginCubit.get(context).loginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80.h),
                        SvgPicture.asset(
                          Assets.imagesSvgLogin,
                          height: 250.h,
                          width: 300.w,
                        )
                            .animate()
                            .fadeIn(duration: const Duration(milliseconds: 700))
                            .scale(),
                        SizedBox(height: 40.h),
                        // Email field
                        CustomTextField(
                          controller: LoginCubit.get(context).emailController,
                          label: "Email",
                          suffixIcon: false,
                          obscureText: false,
                        ).animate().fadeIn(
                            duration: const Duration(milliseconds: 700)),
                        SizedBox(height: 30.h),
                        // Password field
                        CustomTextField(
                          controller:
                              LoginCubit.get(context).passwordController,
                          label: "Password",
                          suffixIcon: true,
                          obscureText: true,
                        ).animate().fadeIn(
                            duration: const Duration(milliseconds: 700)),
                        SizedBox(height: 30.h),
                        // Login button
                        LoginCubit.get(context).isLoading == false
                            ? CustomButton(
                                text: "Login",
                                onPressed: () {
                                  LoginCubit.get(context).loginValidate();
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
