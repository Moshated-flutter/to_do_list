import 'package:flutter/material.dart';
import 'package:to_do_list/presentation/sign_in/log/background/bottombackground.dart';
import 'package:to_do_list/presentation/sign_in/log/background/centerWidget.dart';
import 'package:to_do_list/presentation/sign_in/log/background/topbackground.dart';
import 'package:to_do_list/presentation/sign_in/log/login%20widgets/loginContent.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topbackgroundwidget(screensize.width),
          ),
          Positioned(
            top: 650,
            left: -250,
            child: bottombackgroun(screensize.width),
          ),
          Positioned(
            top: 320,
            left: -350,
            child: centerbackground(screensize.width),
          ),
          const LoginContent(),
        ],
      ),
    );
  }
}
