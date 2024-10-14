import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon = false,
    this.focusNode,
    required this.label,
    this.obscureText = false,
    this.height = 59.0,
    this.readOnly = false,
    this.onTap, // Optional onTap callback
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String label;
  final bool suffixIcon;
  final bool obscureText;
  final double? height;
  final bool readOnly;
  final VoidCallback? onTap; // Added onTap callback

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: widget.height!, // Use the provided height
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText && isvisible,
        focusNode: widget.focusNode,
        readOnly: widget.readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) => setState(() {}),
        onTap: widget.onTap, // Use the onTap callback if provided
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isvisible = !isvisible;
                    });
                  },
                  icon: Icon(
                    isvisible ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : SizedBox(
                  height: 1.h,
                  width: 1.w,
                ),
          labelText: widget.label,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        validator: (value) {
          if (widget.height! < 50 || widget.height! > 100) {
            return 'Height must be between 50 and 100';
          }
          if (value == null || value.isEmpty) {
            return 'Please Enter ${widget.label}';
          }
          return null;
        },
      ),
    );
  }
}
