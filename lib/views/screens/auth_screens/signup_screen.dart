import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/const/const.dart';
import 'package:giphy/controllers/auth_controller.dart';
import 'package:giphy/views/components/custom_text.dart';

import '../../../const/my_theme.dart';
import '../../components/custom_text_field.dart';
import '../../components/rounded_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.emailController.text = "";
        controller.passwordController.text = "";
        return Future.value(true);
      },
      child: GestureDetector(onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: MyTheme.blackColor,
          appBar: AppBar(
              backgroundColor: MyTheme.blackColor,
              elevation: 0,
              leading: const BackButton(
                color: MyTheme.redColor,
              )),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const CustomText(text: 'Create Account', fontWeight: FontWeight.bold, fontSize: 24, textColor: MyTheme.whiteColor),

                    Const.height5,
                    const CustomText(text: 'Please enter your email & password to create an account.', textColor: MyTheme.grey60),
                    Const.height25,
                    CustomTextField(
                      title: 'E-mail',
                      hintText: 'Enter your email address',
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!value.isEmail) {
                          return 'Invalid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    // Password Field.
                    CustomTextField(
                      title: 'Password',
                      hintText: 'Enter your password',
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password should be at least 8 characters long';
                        }
                        return null;
                      },
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 30),
                    RoundedButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) controller.signUp();
                      },
                      label: 'Create An Account',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
