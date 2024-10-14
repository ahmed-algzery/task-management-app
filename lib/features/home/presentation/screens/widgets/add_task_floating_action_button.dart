import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskes/core/color.dart';
import 'package:taskes/features/home/presentation/manager/add_task_cubit/add_task_cubit.dart';
import 'package:taskes/features/home/presentation/screens/widgets/add_task_bottom_sheet_section.dart';

class AddTaskFloatingActionButton extends StatelessWidget {
  const AddTaskFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: mainColor,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          builder: (_) {
            // Reuse the existing cubit instance from the context
            return BlocProvider.value(
              value: BlocProvider.of<AddTaskCubit>(context),
              child: const AddTaskBottomSheetSection(),
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        size: 30.w,
        color: Colors.white,
      ),
    );
  }
}
