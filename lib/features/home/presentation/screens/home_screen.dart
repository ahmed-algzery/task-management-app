import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/core/service_locator.dart';
import 'package:taskes/features/home/data/repo/home_repo_impl.dart';
import 'package:taskes/features/home/presentation/manager/add_task_cubit/add_task_cubit.dart';
import 'package:taskes/features/home/presentation/manager/delete_task_cubit/delete_task_cubit.dart';
import 'package:taskes/features/home/presentation/manager/get_task_cubit/get_task_cubit.dart';
import 'package:taskes/features/home/presentation/manager/update_task_cubit/update_task_cubit.dart';
import 'package:taskes/features/home/presentation/screens/widgets/add_task_floating_action_button.dart';
import 'package:taskes/features/home/presentation/screens/widgets/home_screen_body.dart';
import 'package:taskes/features/login/presentation/screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/homeScreen';

  Future<void> initializeTaskCubit(GetTaskCubit cubit) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      cubit.loadTasksFromLocalStorage();
    } else {
      try {
        cubit.getTaskes();
      } catch (e) {
        cubit.loadTasksFromLocalStorage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = GetTaskCubit(locator<HomeRepoImpl>());
            initializeTaskCubit(cubit);
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => AddTaskCubit(locator<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => UpdateTaskCubit(locator<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => DeleteTaskCubit(locator<HomeRepoImpl>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks', style: TextStyle(color: Colors.white)),
          backgroundColor: mainColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all stored user data

                // Navigate back to the login screen
                GoRouter.of(context).go(LoginScreen.routeName);
              },
            ),
          ],
        ),
        body: const HomeScreenBody(),
        floatingActionButton: const AddTaskFloatingActionButton(),
      ),
    );
  }
}
