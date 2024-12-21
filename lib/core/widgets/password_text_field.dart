import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return 'Required field';
        return null;
      },
      autocorrect: false,
      obscureText: hidePassword,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Styles.style15Medium(context),
        filled: true,
        fillColor: const Color(0xffF7F8F9),
        focusedBorder: borderDecoration(),
        enabledBorder: borderDecoration(),
        errorBorder: errBorderDecoration(),
        focusedErrorBorder: errBorderDecoration(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          icon: hidePassword
              ? const Icon(Icons.visibility_rounded)
              : const Icon(Icons.visibility_off_rounded),
        ),
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
