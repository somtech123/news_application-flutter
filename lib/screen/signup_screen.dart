// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/resources/auth_method.dart';
import 'package:news_app/responsive/mobile_screen_layout.dart';
import 'package:news_app/responsive/responsive_layout.dart';
import 'package:news_app/responsive/web_screen_layout.dart';
import 'package:news_app/screen/login_scrren.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/global_variable.dart';
import 'package:news_app/utils/utils.dart';
import 'package:news_app/widgets/text_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      username: _usernameController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => const ResponsiveLayout(
                mobileScreenLayout: MobileSceenLayout(),
                webScreenLayout: WebScreenLayout(),
              )),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: width > webScreenSize
              ? EdgeInsets.symmetric(horizontal: width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          //  child: SingleChildScrollView(
          child: Column(
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                'assets/svg/undraw_connected_world_wuay.svg',
                height: 60,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                textEditingController: _nameController,
                hintText: "Enter your full name",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 22,
              ),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email address',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: signupUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("already have an account? "),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          //),
        ),
      ),
      // ),
    );
  }
}
