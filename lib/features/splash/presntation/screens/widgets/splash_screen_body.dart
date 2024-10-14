import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskes/core/assets.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/features/splash/data/repo/splash_repo_impl.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();
    SplashRepoImpl().navigateToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [mainColor, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo animation with scaling and slight bounce
          Image.asset(
            Assets.logo,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.fill,
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 700))
              .scaleX(begin: 0.8, end: 1.0)
              .then() // chaining animations for bounce effect
              .scaleY(
                  duration: const Duration(milliseconds: 300),
                  begin: 1.0,
                  end: 1.1),
          SizedBox(height: 40.h),

          // Text animation with fade and slight slide-up effect
          Text(
            'Your Taskes',
            style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(2, 2),
                )
              ],
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 700))
              .slideY(begin: 0.3, end: 0.0) // sliding text into view
              .scaleX(begin: 0.8, end: 1.0),
        ],
      ),
    );
  }
}
