import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.raleway,
  });

  final String text;
  final double? fontSize;
  final int? maxLines;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool? raleway;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: fontSize??16,
        fontWeight: FontWeight.w600,
        height: 1.6,
        letterSpacing: 0.2,
        color: textColor
      ),
      // TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontWeight, fontStyle: fontStyle, decoration: decoration, decorationColor: decorationColor),
      maxLines: maxLines,
    );
  }
}
