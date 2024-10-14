import 'package:dartz/dartz.dart';
import 'package:taskes/core/error/failure.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<TaskModel>>> getTaskes({int limit = 10, int skip = 0});
  Future<Either<Failure, void>> addTask(
      {required String todo, required bool completed});
  Future<Either<Failure, void>> updateTask(
      {required int id, required bool completed});
  Future<Either<Failure, void>> deleteTask({
    required int id,
  });
}
