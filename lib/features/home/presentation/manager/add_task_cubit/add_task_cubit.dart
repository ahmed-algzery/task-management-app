import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskes/features/home/data/repo/home_repo.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(this.homeRepo) : super(AddTaskInitial());
  static AddTaskCubit get(context) => BlocProvider.of(context);
  final HomeRepo homeRepo;
  TextEditingController taskController = TextEditingController();
  bool completed = false;
  GlobalKey<FormState> taskKey = GlobalKey();

  void _addTask() async {
    emit(AddTaskLoading());

    final result =
        await homeRepo.addTask(todo: taskController.text, completed: completed);
    clearControllers();

    result.fold((e) {
      emit(AddTaskFailure(errMessage: e.errMessage));
    }, (_) {
      emit(AddTaskSuccess());
      clearControllers();
    });
  }

  void clearControllers() {
    taskController.clear();
  }

  void taskValidate() {
    if (taskKey.currentState!.validate()) {
      _addTask();
    }
  }

  void _closeControllers() {
    taskController.dispose();
  }

  @override
  Future<void> close() {
    _closeControllers();
    return super.close();
  }

  void toggleCompleted(bool? value) {
    completed = value ?? false;
    emit(ChangeCompelet());
  }
}
