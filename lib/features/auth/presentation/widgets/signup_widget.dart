import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/core/utilis/show_snack_bar.dart';
import 'package:weather_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weather_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:weather_app/features/weather_forecast.dart/presentation/pages/weather_page.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback toggleSignin;
  const SignUpWidget({super.key, required this.toggleSignin});

  @override
  State<SignUpWidget> createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  bool isVisible = false;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WeatherPage()));
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
            height: MediaQuery.of(context).size.height * .7,
            width: MediaQuery.of(context).size.width * .9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.backgroundcolor),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Create your account',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Name',
                        style: TextStyle(color: Colors.grey),
                      ),
                      CustomTextField(
                        hintText: 'Name',
                        controller: nameTextEditingController,
                        icon: Icons.person,
                        onIconTap: () {},
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey),
                      ),
                      CustomTextField(
                        hintText: 'Email',
                        controller: emailTextEditingController,
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
                        controller: passwordTextEditingController,
                        icon: Icons.remove_red_eye_sharp,
                        onIconTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(color: Colors.grey),
                      ),
                      CustomTextField(
                        isPassword: !isVisible,
                        hintText: 'Confirm Password',
                        controller: confirmPasswordTextEditingController,
                        icon: Icons.remove_red_eye,
                        onIconTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('hello');
                            if (key.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignUp(
                                      name: nameTextEditingController.text,
                                      email: emailTextEditingController.text,
                                      password:
                                          passwordTextEditingController.text,
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
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggleSignin();
                            },
                            child: const Text(
                              'Sign In!',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
