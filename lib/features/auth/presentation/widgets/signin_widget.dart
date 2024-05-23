import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utilis/show_snack_bar.dart';
import 'package:weather_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weather_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:weather_app/features/weather_forecast.dart/presentation/pages/weather_page.dart';

class SignInWidget extends StatelessWidget {
  final bool isVisible;
  final bool switchToSignUp;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback togglePasswordVisibility;
  final VoidCallback toggleSignUp;

  SignInWidget({
    Key? key,
    required this.switchToSignUp,
    required this.isVisible,
    required this.emailController,
    required this.passwordController,
    required this.togglePasswordVisibility,
    required this.toggleSignUp,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showSnackBar(context, state.user.email);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WeatherPage()));
        } else if (state is AuthFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Row(children: [
          Container(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.backgroundcolor),
                ),
                const Text(
                  'Sign in to continue',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.grey),
                        ),
                        CustomTextField(
                          hintText: 'Email',
                          controller: emailController,
                          icon: Icons.email,
                          onIconTap: () {},
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.grey),
                        ),
                        CustomTextField(
                          isPassword: !isVisible,
                          hintText: 'Password',
                          controller: passwordController,
                          icon: Icons.remove_red_eye,
                          onIconTap: togglePasswordVisibility,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.black45,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: AppPallete.backgroundcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        toggleSignUp();
                      },
                      child: const Text(
                        'SignUp !',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
