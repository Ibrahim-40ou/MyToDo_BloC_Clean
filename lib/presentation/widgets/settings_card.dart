import 'package:flutter/material.dart';
import 'package:mytodo_bloc/presentation/widgets/text.dart';
import 'package:sizer/sizer.dart';
import 'button.dart';

class SettingsCard extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final String text;
  final Color textsColor;
  final Widget icon;
  final Function function;

  const SettingsCard({
    super.key,
    required this.label,
    required this.text,
    required this.icon,
    required this.function,
    required this.buttonColor,
    required this.textsColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      child: MyButton(
        function: () {
          function();
        },
        height: 100,
        width: (100.w - 48) / 2,
        color: buttonColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: label,
                        size: 18,
                        weight: FontWeight.w600,
                        color: textsColor,
                      ),
                      MyText(
                        text: text,
                        size: 14,
                        color: textsColor,
                      ),
                    ],
                  ),
                  icon,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
