import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphy/const/const.dart';
import 'package:giphy/controllers/auth_controller.dart';
import 'package:giphy/views/components/custom_text.dart';
import 'package:giphy/views/screens/auth_screens/signup_screen.dart';

import '../../../const/my_theme.dart';
import '../../components/custom_text_field.dart';
import '../../components/rounded_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController controller=Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.blackColor,
      appBar: AppBar(
          backgroundColor: MyTheme.blackColor,
          elevation: 0,
          leading: const BackButton(
            color: MyTheme.redColor,
          )),
      body: GestureDetector(onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  CustomText(text: "Let’s Sign you in",textColor: MyTheme.whiteColor,fontSize: 20,),
                  Const.height5,
                  CustomText(text: "Please enter your email & password to sign in.",textColor: MyTheme.grey60,),
                  Const.height20,
                  // Email Field.
                  CustomTextField(
                    title: 'Email Address',
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
                  Const.height20,
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
                  Const.height40,
                  RoundedButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signIn();
                      }
                    },
                     label: 'Sign In',
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyTheme.grey70),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()..onTap = () {
                            controller.emailController.text="";
                            controller.passwordController.text="";
                            Get.to(SignUpScreen());},
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: MyTheme.redColor),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.red,
          fontSize: fontSize ?? 14,
        ),
      ),
    );
  }
}

class RememberMeCard extends StatefulWidget {
  final Function(bool isChecked) onChanged;
  const RememberMeCard({required this.onChanged, super.key});

  @override
  State<RememberMeCard> createState() => _RememberMeCardState();
}

class _RememberMeCardState extends State<RememberMeCard> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
            widget.onChanged(_isChecked);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isChecked
                    ? const Color(0xFFD1A661)
                    : const Color(0xFFE3E9ED),
                width: 2,
              ),
            ),
            child: _isChecked
                ? const Icon(
              Icons.check,
              size: 16,
              color: Color(0xFFD1A661),
            )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Remember me',
          style: TextStyle(fontSize: 14, color: Color(0xFF78828A)),
        ),
      ],
    );
  }
}
