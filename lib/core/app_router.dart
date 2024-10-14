import 'package:taskes/core/widget/custom_transaction_screen.dart';
import 'package:taskes/features/home/presentation/screens/home_screen.dart';
import 'package:taskes/features/login/presentation/screen/login_screen.dart';
import 'package:taskes/features/splash/presntation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (context, state) => CustomTransactionScreen(
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        pageBuilder: (context, state) => CustomTransactionScreen(
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        pageBuilder: (context, state) => CustomTransactionScreen(
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
