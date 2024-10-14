import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:taskes/core/api_services.dart';
import 'package:taskes/core/error/failure.dart';
import 'package:taskes/features/login/data/model/login_response.dart';
import 'package:taskes/features/login/data/repo/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);
  @override
  Future<Either<Failure, UserResponse>> login(
      {required String userName, required String password}) async {
    try {
      var data = await apiService.post(endPoint: '/auth/login', data: {
        "username": userName,
        "password": password,
      });

      UserResponse userResponse = UserResponse.fromJson(data);
      return right(userResponse);
    } catch (e) {
      Logger().e(e.toString());
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
