import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return 'Required field';
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Styles.style15Medium(context),
        filled: true,
        fillColor: const Color(0xffF7F8F9),
        focusedBorder: borderDecoration(),
        enabledBorder: borderDecoration(),
        errorBorder: errBorderDecoration(),
        focusedErrorBorder: errBorderDecoration(),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  OutlineInputBorder borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xffE8ECF4),
        width: 2,
      ),
    );
  }

  OutlineInputBorder errBorderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
    );
  }
}
