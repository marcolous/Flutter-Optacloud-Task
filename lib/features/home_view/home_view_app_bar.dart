import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Babylon',
        style: Styles.style30(context),
      ),
    );
  }
}
