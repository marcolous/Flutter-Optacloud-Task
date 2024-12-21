import 'package:flutter/material.dart';

class CustomDefaultButton extends StatelessWidget {
  const CustomDefaultButton(
      {super.key, required this.iconData, required this.onPressed});
  final IconData iconData;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 60,
          height: 60,
          child: IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: Color(0xffE8ECF4),
                    width: 2,
                  ),
                ),
              ),
            ),
            icon: Icon(
              iconData,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
