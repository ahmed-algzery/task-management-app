import 'package:dio/dio.dart';
import 'package:taskes/core/api_services.dart';

import 'package:get_it/get_it.dart';
import 'package:taskes/features/home/data/repo/home_repo_impl.dart';
import 'package:taskes/features/login/data/repo/login_repo_impl.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(
    ApiService(
      Dio(),
    ),
  );

  locator.registerLazySingleton(
    () => LoginRepoImpl(
      locator<ApiService>(),
    ),
  );

  locator.registerLazySingleton(
    () => HomeRepoImpl(
      locator<ApiService>(),
    ),
  );
}
