import 'package:flutter/material.dart';
import 'package:to_do_list/presentation/sign_in/log/login%20widgets/animations/changeAnimation.dart';
import 'package:to_do_list/presentation/sign_in/log/login%20widgets/animations/helper_funtions.dart';
import 'package:to_do_list/presentation/sign_in/log/login%20widgets/texts/bottomText.dart';
import 'package:to_do_list/presentation/sign_in/log/login%20widgets/texts/topText.dart';

enum Screens {
  createAccount,
  login,
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  final formkeyEmialLog = GlobalKey<FormState>();
  final formkeyEmialSign = GlobalKey<FormState>();
  final formKeyPasswordSign = GlobalKey<FormState>();
  // final formkeyPasswordLog = GlobalKey<FormState>();
  // final formkeyPasswordSing = GlobalKey<FormState>();
  final formKeyPasswordLog = GlobalKey<FormState>();

  late final List<Widget> createAcounntWidget;
  late final List<Widget> loginWidgets;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero);
    loginWidgets = [
      inputField(
        'Email',
        Icons.person,
        false,
        formkeyEmialLog,
      ),
      inputField(
        'Password',
        Icons.person,
        false,
        formKeyPasswordLog,
      ),
      customButton('Log in'),
    ];
    createAcounntWidget = [
      inputField(
        'Email',
        Icons.person_outline,
        false,
        formkeyEmialSign,
      ),
      inputField(
        'Password',
        Icons.phone_android,
        false,
        formKeyPasswordSign,
      ),
      customButton('Sign in'),
      ordivider(),
      googleLogo(),
    ];
    ChangeAnimations.initialze(
      vsync: this,
      createAccountItem: createAcounntWidget.length,
      loginItems: loginWidgets.length,
    );
    for (var i = 0; loginWidgets.length > i; i++) {
      loginWidgets[i] = HelperFunction.wrapWithAnimationBuilder(
        animation: ChangeAnimations.loginAnime[i],
        child: loginWidgets[i],
      );
    }
    for (var i = 0; createAcounntWidget.length > i; i++) {
      createAcounntWidget[i] = HelperFunction.wrapWithAnimationBuilder(
        animation: ChangeAnimations.createAccuontAnime[i],
        child: createAcounntWidget[i],
      );
    }
  }

  Widget ordivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              color: Colors.black,
              height: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.black,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget googleLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget customButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 135),
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(
    String hint,
    IconData iconData,
    bool obscure,
    GlobalKey<FormState> formkey,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 55,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: Form(
            key: formkey,
            child: TextFormField(
              textAlign: TextAlign.right,
              validator: (value) {
                if (hint == 'Email') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (!value.contains('@')) {
                    return 'please enter a valid value';
                  }
                }
                if (hint == 'Password') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (value.length < 7) {
                    return 'please enter at least 7 characters';
                  }
                }
                if (hint == 'Name') {
                  if (value!.isEmpty) {
                    return 'This field cant be empty ';
                  }
                  if (value.length < 4) {
                    return 'please enter at least 4 characters';
                  }
                }
                return null;
              },
              textDirection: TextDirection.rtl,
              onSaved: (newValue) {},
              obscureText: obscure,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                prefixIcon: Icon(iconData),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 570,
          right: 50,
          child: TopText(),
        ), // Center(child: CircularProgressIndicator())

        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginWidgets,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAcounntWidget,
              ),
              Positioned(
                left: 130,
                child: BottomText(),
                bottom: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
