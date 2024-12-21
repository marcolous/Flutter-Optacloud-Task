import 'package:optacloud_task/core/utils/routes.dart';
import 'package:optacloud_task/features/home_view/home_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(context),
      body: const SafeArea(
        child: HomeViewBody(),
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.kLoginScreen,
          (route) => false,
        );
      },
      child: const Icon(
        Icons.logout_outlined,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
