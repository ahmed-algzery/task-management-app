import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/features/home/presentation/screens/home_screen.dart';
import 'package:taskes/features/login/presentation/screen/login_screen.dart';
import 'package:taskes/features/splash/data/repo/splash_repo.dart';
import 'package:go_router/go_router.dart';

class SplashRepoImpl implements SplashRepo {
  @override
  navigateToHome(context) {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        if (pref.getString('token') != null &&
            pref.getString('token')!.isNotEmpty) {
          GoRouter.of(context).pushReplacement(HomeScreen.routeName);
        } else {
          GoRouter.of(context).pushReplacement(LoginScreen.routeName);
        }
      },
    );
  }
}
