import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_bloc/presentation/widgets/button.dart';

import '../presentation/widgets/text.dart';

class Common {
  String? validateField(String? value) =>
      value == null || value.isEmpty ? 'This field is required' : null;

  String? validateEmail(String? email) =>
      EmailValidator.validate(email!.trim()) ? null : 'Enter a valid email';

  String? validatePassword(String? value) => value == null || value.isEmpty
      ? 'This field is required'
      : value.length < 6
          ? 'Password must be longer than 6 characters'
          : null;

  void showSnackBar(BuildContext context, String text) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            MyText(
              text: text,
              size: 16,
              weight: FontWeight.normal,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  void showDialogue(
    BuildContext context,
    String errorText,
    String message,
    Function exitDialogue,
    Function confirmFunction,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            exitDialogue();
            return true;
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: MyText(
              text: errorText.isNotEmpty ? 'Error Occurred' : 'Confirmation',
              color: errorText.isNotEmpty
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            content: MyText(
              text: errorText.isNotEmpty ? errorText : message,
              color: Colors.black,
            ),
            actions: <Widget>[
              MyButton(
                function: () {
                  Navigator.pop(context);
                  confirmFunction();
                },
                color: Theme.of(context).colorScheme.primary,
                child: MyText(
                  text: errorText.isNotEmpty ? 'Okay' : 'Confirm',
                  color: Colors.white,
                ),
              ),
              errorText.isNotEmpty
                  ? Container()
                  : MyButton(
                      border: true,
                      borderColor: Colors.black,
                      function: () {
                        Navigator.pop(context);
                        exitDialogue();
                      },
                      color: Colors.white,
                      child: const MyText(
                        text: 'Cancel',
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}