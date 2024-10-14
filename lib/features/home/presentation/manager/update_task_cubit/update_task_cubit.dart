import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskes/features/home/data/repo/home_repo.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit(this.homeRepo) : super(UpdateTaskInitial());
  static UpdateTaskCubit get(context) => BlocProvider.of(context);
  final HomeRepo homeRepo;
  void updateTask({
    required bool completed,
    required int id,
  }) async {
    emit(UpdateTaskLoading());
    final result = await homeRepo.updateTask(id: id, completed: completed);
    result.fold((e) {
      emit(UpdateTaskFailure(errMessage: e.errMessage));
    }, (_) {
      emit(UpdateTaskSuccess());
    });
  }
}
