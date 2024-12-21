import 'package:optacloud_task/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class CustomGoogleButton extends StatelessWidget {
  const CustomGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0xffE8ECF4),
              width: 2,
            ),
          ),
          backgroundColor: Colors.white,
          overlayColor: const Color(0xff1E232C),
          elevation: 0,
        ),
        child: AppImages.googleSvg,
      ),
    );
  }
}
