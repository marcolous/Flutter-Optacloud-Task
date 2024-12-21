import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomOrWith extends StatelessWidget {
  const CustomOrWith({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Divider(
          thickness: 2,
          color: Color(0xffE8ECF4),
          height: 20,
        ),
        Align(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white,
            child: Text(
              title,
              style: Styles.style14(context),
            ),
          ),
        ),
      ],
    );
  }
}
