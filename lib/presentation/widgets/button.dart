import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback function;
  final double? height;
  final double? width;
  final Color color;
  final Widget child;
  final double elevation;
  final bool disabled;
  final bool border;
  final Color? borderColor;

  const MyButton({
    super.key,
    required this.function,
    required this.color,
    required this.child,
    this.height,
    this.width,
    this.borderColor,
    this.elevation = 0,
    this.disabled = false,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        elevation: elevation,
        onPressed: disabled ? () {} : function,
        color: disabled ? color.withOpacity(0.7) : color,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: border
              ? BorderSide(
                  width: 1,
                  color: borderColor != null
                      ? borderColor!
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                )
              : BorderSide.none,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
