import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  const CustomAppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final void Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
          border: Border.all(
            color: Colors.grey,
            width: 2,
          )),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 30),
      ),
    );
  }
}
