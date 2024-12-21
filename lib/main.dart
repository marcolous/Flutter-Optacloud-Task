import 'package:optacloud_task/features/auth/login_view/login_view.dart';
import 'package:optacloud_task/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:optacloud_task/features/auth/register_view/register_view.dart';
import 'package:optacloud_task/features/home_view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:optacloud_task/core/utils/routes.dart';
import 'package:optacloud_task/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Optacloud());
}

class Optacloud extends StatelessWidget {
  const Optacloud({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginView()
            : const HomeView(),
        routes: {
          Routes.kLoginScreen: (context) => const LoginView(),
          Routes.kRegisterScreen: (context) => const RegisterView(),
          Routes.kHomeScreen: (context) => const HomeView(),
        },
      ),
    );
  }
}
