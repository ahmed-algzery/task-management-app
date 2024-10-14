import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTransactionScreen<T> extends CustomTransitionPage<T> {
  CustomTransactionScreen({
    required super.child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: duration,
        );
}
