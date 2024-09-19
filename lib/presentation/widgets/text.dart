import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_bloc/main.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final int? maxLines;

  const MyText({
    super.key,
    required this.text,
    this.size = 16,
    this.weight = FontWeight.normal,
    this.color,
    this.align,
    this.overflow,
    this.decoration,
    this.maxLines,
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
      textAlign: align ??
          (Localizations.localeOf(context).toString() == 'en_US'
              ? TextAlign.left
              : TextAlign.right),
      overflow: overflow,
      maxLines: maxLines,
    ).tr();
  }
}
