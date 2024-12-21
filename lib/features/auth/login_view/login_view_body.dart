import 'package:optacloud_task/core/utils/no_bounce_scroll_behavior.dart';
import 'package:optacloud_task/core/utils/routes.dart';
import 'package:optacloud_task/core/utils/show_snack_bar.dart';
import 'package:optacloud_task/core/utils/styles.dart';
import 'package:optacloud_task/core/widgets/custom_button.dart';
import 'package:optacloud_task/core/widgets/custom_google_button.dart';
import 'package:optacloud_task/core/widgets/custom_or_with.dart';
import 'package:optacloud_task/core/widgets/custom_progress_indicator.dart';
import 'package:optacloud_task/core/widgets/custom_row.dart';
import 'package:optacloud_task/core/widgets/email_text_field.dart';
import 'package:optacloud_task/core/widgets/password_text_field.dart';
import 'package:optacloud_task/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({
    super.key,
  });

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, Routes.kHomeScreen);
          isLoading = false;
        } else if (state is LoginFailure) {
          ShowSnackBar.show(context, state.errMsg);

          isLoading = false;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: formKey,
              child: ScrollConfiguration(
                behavior: NoBounceScrollBehavior(),
                child: ListView(
                  children: [
                    const Gap(50),
                    Text(
                      'Welcome back! Glad to see you, Again!',
                      style: Styles.style30(context),
                    ),
                    const Gap(32),
                    EmailTextField(
                        hintText: 'Enter your email', controller: _email),
                    const Gap(15),
                    PasswordTextField(
                        hintText: 'Enter your Password', controller: _password),
                    const Gap(15),
                    const Gap(30),
                    CustomProgressIndicator(
                      isLoading: isLoading,
                      child: CustomButton(
                        title: 'Login',
                        onPressed: () => _login(
                            email: _email.text, password: _password.text),
                      ),
                    ),
                    const Gap(35),
                    const CustomOrWith(title: 'Or Login with'),
                    const Gap(22),
                    const CustomGoogleButton(),
                    CustomRow(
                      title: 'Don\'t have an account? ',
                      subTitle: 'Register Now',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.kRegisterScreen);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _login({required String email, required String password}) async {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .login(email: email, password: password);
    }
  }
}
