import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;
  final VoidCallback onIconTap;

  const CustomTextField({
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.icon,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: onIconTap,
        ),
      ),
      obscureText: isPassword,
      validator: (value){
        if(value!.isEmpty){
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}