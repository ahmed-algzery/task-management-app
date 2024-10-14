part of 'get_task_cubit.dart';

@immutable
sealed class GetTaskState {}

final class GetTaskInitial extends GetTaskState {}

final class GetTaskLoading extends GetTaskState {}

final class GetTaskSuccess extends GetTaskState {
  final List<TaskModel> tasks;
  GetTaskSuccess({required this.tasks});
}

final class GetTaskFailure extends GetTaskState {
  final String errMessage;
  GetTaskFailure({required this.errMessage});
}

final class ChangeCompelet extends GetTaskState {}

final class GetTaskLoadMoreLoading extends GetTaskState {}

