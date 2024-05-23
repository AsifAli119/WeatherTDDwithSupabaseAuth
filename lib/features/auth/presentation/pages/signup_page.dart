import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/features/auth/presentation/widgets/signin_widget.dart';
import 'package:weather_app/features/auth/presentation/widgets/signup_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

bool isSignin = true;
bool isVisible = false;


class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();

@override
void dispose(){
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Welcome Back',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomSheet: isSignin? SignInWidget(
        isVisible: isVisible,
        emailController: emailTextEditingController,
        passwordController: passwordTextEditingController,
        togglePasswordVisibility: () {
          setState(() {
            isVisible = !isVisible;
          });
        }, switchToSignUp: isSignin, toggleSignUp: () { 
          setState(() {
            isSignin = !isSignin;
          });
         },
      ): SignUpWidget(toggleSignin: () { 
        setState(() {
          isSignin = !isSignin;
        });
       },),
    );
  }
}



