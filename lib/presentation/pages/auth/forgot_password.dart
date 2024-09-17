import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodo_bloc/presentation/widgets/text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../core/common_functions.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final _key = GlobalKey<FormState>();

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthBack) {
          Common().showDialogue(
            context,
            '',
            'Are you sure you want to leave? All data entered will be lost.',
            () {},
            () {
              Navigator.pop(context);
            },
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<AuthBloc>().add(AuthBackPressed());
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 13.h),
                        MyButton(
                          function: () {
                            context.read<AuthBloc>().add(AuthBackPressed());
                          },
                          height: 56,
                          width: 56,
                          color: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            CupertinoIcons.back,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const MyText(
                                  text: 'Forgot',
                                  size: 26,
                                  weight: FontWeight.w600,
                                ),
                                MyText(
                                  text: ' Password?',
                                  size: 26,
                                  weight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 90.w,
                              child: MyText(
                                text:
                                    'Enter the email address the corresponds with your account.',
                                size: 14,
                                weight: FontWeight.normal,
                                color: isDarkMode
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                    : Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.color,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        MyField(
                          controller: _email,
                          labelText: 'Email',
                          isLast: true,
                          prefixIcon: SvgPicture.asset(
                            'assets/email.svg',
                            fit: BoxFit.scaleDown,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          validatorFunction: Common().validateEmail,
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                          function: () {},
                          color: Theme.of(context).colorScheme.primary,
                          disabled:
                              state == ForgotPasswordLoading() ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (state is ForgotPasswordLoading)
                                const Row(
                                  children: [
                                    LoadingIndicator(
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              SvgPicture.asset(
                                'assets/send.svg',
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 8),
                              const MyText(
                                text: 'Send',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 29.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const MyText(
                              text: "Remembered your password?",
                              size: 16,
                              weight: FontWeight.normal,
                            ),
                            MyButton(
                              height: 3.h,
                              function: () {
                                Navigator.pop(context);
                              },
                              color: Theme.of(context).colorScheme.surface,
                              child: MyText(
                                text: 'Sign in',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
