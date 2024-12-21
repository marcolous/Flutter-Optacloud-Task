import 'package:firebase_auth/firebase_auth.dart';
import 'package:optacloud_task/core/utils/routes.dart';
import 'package:optacloud_task/core/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Optacloud',
          style: Styles.style30(context),
        ),
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.kLoginScreen,
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.black,
            size: 30,
          ),
        )
      ],
    );
  }
}
