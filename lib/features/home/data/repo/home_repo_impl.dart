import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/core/api_services.dart';
import 'package:taskes/core/error/failure.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';
import 'package:taskes/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failure, void>> addTask(
      {required String todo, required bool completed}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      final response = await apiService.post(
          endPoint: '/todos/add',
          data: {'todo': todo, 'completed': completed, 'userId': userId});
      // ignore: void_checks
      return Right(response);
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

  @override
  Future<Either<Failure, void>> deleteTask({required int id}) async {
    try {
      final response = await apiService.delete(endPoint: '/todos/$id');
      // ignore: void_checks
      return Right(response);
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

// Update the getTaskes method to include pagination parameters
  @override
  Future<Either<Failure, List<TaskModel>>> getTaskes(
      {int limit = 10, int skip = 0}) async {
    try {
      final response =
          await apiService.get(endPoint: '/todos', queryParameters: {
        'limit': limit,
        'skip': skip,
      });

      List<dynamic> taskesList = response['todos'];
      if (taskesList.isNotEmpty) {
        List<TaskModel> taskes =
            taskesList.map((taskData) => TaskModel.fromJson(taskData)).toList();
        return right(taskes);
      } else {
        return right([]);
      }
    } catch (e) {
      Logger().e(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(
      {required int id, required bool completed}) async {
    try {
      final response = await apiService.update(endPoint: '/todos/$id', data: {
        'completed': completed,
      });
      // ignore: void_checks
      return Right(response);
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
