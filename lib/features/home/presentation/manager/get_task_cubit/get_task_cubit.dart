import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';
import 'package:taskes/features/home/data/repo/home_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'get_task_state.dart';

class GetTaskCubit extends Cubit<GetTaskState> {
  GetTaskCubit(this.homeRepo) : super(GetTaskInitial());
  static GetTaskCubit get(context) => BlocProvider.of(context);
  final HomeRepo homeRepo;

  List<TaskModel> tasksList = [];
  bool hasMoreTasks = true;
  int currentPage = 0;
  final int limit = 10;

  // Check for internet connection
  Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Load tasks from local storage (SharedPreferences)
  Future<void> loadTasksFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedTasks = prefs.getString('tasks');
    if (cachedTasks != null) {
      List<TaskModel> cachedList = (json.decode(cachedTasks) as List)
          .map((task) => TaskModel.fromJson(task))
          .toList();
      tasksList = cachedList;
      emit(GetTaskSuccess(tasks: tasksList));
    }
  }

  // Save tasks to local storage (SharedPreferences)
  Future<void> saveTasksToLocalStorage(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }

  // Fetch tasks from the server or local storage
  void getTaskes({bool isLoadMore = false}) async {
    // Check for internet connection first
    final hasInternet = await hasInternetConnection();

    if (!hasInternet) {
      // If no internet, load tasks from local storage
      await loadTasksFromLocalStorage();
      return;
    }

    if (isLoadMore && !hasMoreTasks) return;

    emit(isLoadMore ? GetTaskLoadMoreLoading() : GetTaskLoading());

    var result =
        await homeRepo.getTaskes(limit: limit, skip: currentPage * limit);
    result.fold((e) {
      emit(GetTaskFailure(errMessage: e.errMessage));
    }, (tasks) async {
      if (tasks.isEmpty) {
        hasMoreTasks = false;
      } else {
        currentPage += 1;
        if (isLoadMore) {
          tasksList.addAll(tasks);
        } else {
          tasksList = tasks;
        }
        emit(GetTaskSuccess(tasks: tasksList));

        // Save tasks to local storage
        await saveTasksToLocalStorage(tasksList);
      }
    });
  }
}
