import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const MyText({
    super.key,
    required this.text,
    this.size = 16,
    this.weight = FontWeight.normal,
    this.color,
    this.align,
    this.overflow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: size,
        fontWeight: weight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        decoration: decoration,
      ),
      textAlign: align,
      overflow: overflow,
    );
  }
}
