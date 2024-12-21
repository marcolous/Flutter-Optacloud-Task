import 'package:optacloud_task/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AppImages.notes2Svg,
    );
  }
}
