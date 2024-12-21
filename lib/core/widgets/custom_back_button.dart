import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

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
            onPressed: () {
              Navigator.pop(context);
            },
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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
