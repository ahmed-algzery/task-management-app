import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity package
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskes/core/styles.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';
import 'package:taskes/features/home/presentation/manager/get_task_cubit/get_task_cubit.dart';
import 'package:taskes/features/home/presentation/screens/widgets/task_item.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTaskCubit, GetTaskState>(
      builder: (context, state) {
        if (state is GetTaskSuccess) {
          if (GetTaskCubit.get(context).tasksList.isEmpty) {
            return Center(
              child: Text('No Tasks', style: Styles.textstyle20),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetTaskCubit>().getTaskes();
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    _checkConnectivityAndLoadMore(context);
                  }
                  return true;
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: GetTaskCubit.get(context).tasksList.length +
                      1, // Add 1 for the loader
                  itemBuilder: (context, index) {
                    if (index == GetTaskCubit.get(context).tasksList.length) {
                      // Show the CircularProgressIndicator when loading more tasks
                      if (state is GetTaskLoadMoreLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return const SizedBox(); // Return an empty box if not loading more
                    } else {
                      return TaskItem(
                        taskModel: GetTaskCubit.get(context).tasksList[index],
                      );
                    }
                  },
                ),
              ),
            );
          }
        } else if (state is GetTaskFailure) {
          return Center(
            child: Text(state.errMessage, style: Styles.textstyle20),
          );
        } else if (state is GetTaskLoading) {
          return Skeletonizer(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModel: TaskModel(
                    id: 0,
                    todo: 'todo',
                    completed: true,
                    userId: 0,
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('No Tasks', style: Styles.textstyle20),
          );
        }
      },
    );
  }

  Future<void> _checkConnectivityAndLoadMore(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      log('No internet connection. Cannot load more tasks.');
    } else {
      // ignore: use_build_context_synchronously
      context.read<GetTaskCubit>().getTaskes(isLoadMore: true);
    }
  }
}
