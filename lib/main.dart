import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskes/core/bloc_observer.dart';
import 'package:taskes/core/service_locator.dart';
import 'package:taskes/taskes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  Bloc.observer = MyBlocObserver();
  runApp(
    const Taskes(),
  );
}
