import 'package:optacloud_task/core/utils/styles.dart';
import 'package:optacloud_task/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:optacloud_task/features/home_view/home_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final name = await authCubit.getUsername();
    setState(() => username = name);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const HomeScreenAppBar(),
            const Gap(20),
            Expanded(
              child: Center(
                child: Text(
                  'Hey, $username You’re successfully logged in,',
                  style: Styles.style23(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
