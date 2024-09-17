import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MyField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool showPassword;
  final bool isLast;
  final bool isName;
  final TextInputType type;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? suffixIconFunction;
  final String? Function(String?)? validatorFunction;
  final bool? enabled;

  const MyField({
    super.key,
    required this.controller,
    required this.labelText,
    this.width,
    this.isPassword = false,
    this.showPassword = false,
    this.isLast = false,
    this.isName = false,
    this.type = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconFunction,
    this.validatorFunction,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100.w,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: showPassword,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        textCapitalization:
            isName ? TextCapitalization.sentences : TextCapitalization.none,
        keyboardType: type,
        style: GoogleFonts.cairo(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.cairo(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).textTheme.bodyMedium?.color
                : Theme.of(context).textTheme.labelMedium?.color,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorStyle: GoogleFonts.cairo(
            fontSize: 14,
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.normal,
          ),
          errorMaxLines: 10,
        ),
        validator: validatorFunction,
      ),
    );
  }
}
