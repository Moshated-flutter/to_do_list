import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/auth/signIn_form/bloc/sign_in_bloc.dart';
import 'package:to_do_list/injection.dart';
import 'package:to_do_list/presentation/sign_in/log/LoginScreen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInBloc>(),
      child: LoginScreen(),
    );
  }
}
