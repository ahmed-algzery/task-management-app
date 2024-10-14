import 'package:dartz/dartz.dart';
import 'package:taskes/core/error/failure.dart';
import 'package:taskes/features/login/data/model/login_response.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserResponse>> login({required String userName,required String password});
}
