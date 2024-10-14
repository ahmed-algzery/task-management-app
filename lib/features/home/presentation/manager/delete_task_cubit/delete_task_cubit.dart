import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskes/features/home/data/repo/home_repo.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit(this.homeRepo) : super(DeleteTaskInitial());
  static DeleteTaskCubit get(context) => BlocProvider.of(context);
  final HomeRepo homeRepo;
  void deleteTask({required int id}) async {
    emit(DeleteTaskLoading());
    final result = await homeRepo.deleteTask(id: id);

    result.fold((e) {
      emit(DeleteTaskFailure(errMessage: e.errMessage));
    }, (_) {
      emit(DeleteTaskSuccess());
    });
  }
}
