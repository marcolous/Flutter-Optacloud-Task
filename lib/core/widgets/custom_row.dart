import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final String title, subTitle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Styles.style15Medium(context).copyWith(
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              subTitle,
              style: Styles.style15(context).copyWith(
                color: const Color(0xff35C2C1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
