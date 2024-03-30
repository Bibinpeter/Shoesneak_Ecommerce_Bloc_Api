import 'package:flutter/material.dart';

class TextFormFieldWidgetadmin extends StatelessWidget {
  const TextFormFieldWidgetadmin(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      required this.errorText,
      this.suffixIcon,
      this.obscureText,});

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String errorText;
  final IconData? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 101, 101, 101),

            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null; // Valid
        },
      ),
    );
  }
}