import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator(
      {super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6,
      child: ModalProgressHUD(
        color: Colors.white,
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}