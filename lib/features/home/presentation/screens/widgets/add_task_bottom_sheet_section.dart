import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskes/core/functions/custom_snack_bar.dart';
import 'package:taskes/core/widget/custom_button.dart';
import 'package:taskes/core/widget/custom_textfield.dart';
import 'package:taskes/features/home/presentation/manager/add_task_cubit/add_task_cubit.dart';

class AddTaskBottomSheetSection extends StatelessWidget {
  const AddTaskBottomSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust for keyboard height
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Form(
            key: AddTaskCubit.get(context).taskKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: AddTaskCubit.get(context).taskController,
                  label: 'Task Name',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    BlocBuilder<AddTaskCubit, AddTaskState>(
                      builder: (context, state) {
                        return Checkbox(
                          value: AddTaskCubit.get(context).completed,
                          onChanged: (value) {
                            AddTaskCubit.get(context).toggleCompleted(value);
                          },
                        );
                      },
                    ),
                    Text(
                      'Task Completed',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                BlocConsumer<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskSuccess) {
                      showSnackBar(context, 'Task is Added', true);
                    } else if (state is AddTaskFailure) {
                      showSnackBar(context, state.errMessage, false);
                    }
                  },
                  builder: (context, state) {
                    return state is AddTaskLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Save',
                                  onPressed: () {
                                    AddTaskCubit.get(context).taskValidate();
                                    // context.read<GetTaskCubit>().getTaskes();
                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: CustomButton(
                                  text: "Cancel",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
