import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/my_theme.dart';
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onTap,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.style,
    super.key,
  });
  final void Function() onTap;
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        width: width ?? Get.width,
        height: (height ?? 58),
        decoration: BoxDecoration(
          color: color ?? MyTheme.redColor,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: style ??
              GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.6,
                letterSpacing: 0.2,
              ).copyWith(
                color: MyTheme.whiteColor,
              ),
        ),
      ),
    );
  }
}