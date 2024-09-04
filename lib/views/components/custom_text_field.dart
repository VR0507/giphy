import 'package:flutter/material.dart';
import 'package:giphy/views/components/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/my_theme.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final Color? titleColor;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLines;
  final Function(String)? onChanged;

  const CustomTextField({
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.titleColor,
    this.onChanged,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.isPassword = false,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          CustomText(text: widget.title,fontSize: 14,textColor: widget.titleColor ?? const Color(0xFF78828A),),
        if (widget.title.isNotEmpty) const SizedBox(height: 5),
        TextFormField(
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: MyTheme.blackColor,
            letterSpacing: 0.2,
          ),
          controller: widget.controller,
          validator: widget.validator,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          onChanged: widget.onChanged,
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: widget.isPassword ? isObscure : false,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            fillColor: const Color(0xFFF6F6F6),
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: MyTheme.grey60),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF171725)),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
