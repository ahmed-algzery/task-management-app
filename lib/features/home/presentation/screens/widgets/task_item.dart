import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/core/functions/custom_snack_bar.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';
import 'package:taskes/features/home/presentation/manager/get_task_cubit/get_task_cubit.dart';
import 'package:taskes/features/home/presentation/manager/update_task_cubit/update_task_cubit.dart';
import 'package:taskes/features/home/presentation/manager/delete_task_cubit/delete_task_cubit.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateTaskCubit, UpdateTaskState>(
          listener: (context, state) {
            if (state is UpdateTaskSuccess) {
              context.read<GetTaskCubit>().getTaskes();
            } else if (state is UpdateTaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
        ),
        BlocListener<DeleteTaskCubit, DeleteTaskState>(
          listener: (context, state) {
            if (state is DeleteTaskSuccess) {
              showSnackBar(context, 'Task deleted', true);
              context.read<GetTaskCubit>().getTaskes();
            } else if (state is DeleteTaskFailure) {
              showSnackBar(context, state.errMessage, false);
            }
          },
        ),
      ],
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  taskModel.todo,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: textcolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Checkbox(
                value: taskModel.completed,
                onChanged: (value) {
                  context.read<UpdateTaskCubit>().updateTask(
                        id: taskModel.id,
                        completed: value ?? false,
                      );
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<DeleteTaskCubit>().deleteTask(id: taskModel.id);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 500)).scale(),
    );
  }
}
