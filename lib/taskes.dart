import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskes/core/app_router.dart';

class Taskes extends StatelessWidget {
  const Taskes({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router, // The router configuration
            debugShowCheckedModeBanner: false, // Removing debug banner

            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor:
                  Colors.white, // Setting primary scaffold background color
              textTheme:
                  GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
            ),
          );
        });
  }
}
