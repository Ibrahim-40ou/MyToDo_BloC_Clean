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
import '../app/app.dart';

class Register extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  Register({super.key});

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
        if (state is RegisterFailure) {
          Common().showDialogue(
            context,
            state.message,
            '',
            () {},
            () {},
          );
        }
        if (state is RegisterSuccess || state is GoogleSignInSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => App()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        bool showPassword = true;
        if (state is RegisterShowPasswordToggled) {
          showPassword = state.showPassword;
        }
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
                        SizedBox(height: 8.h),
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
                        const SizedBox(height: 48),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const MyText(
                                  text: 'Create',
                                  size: 26,
                                  weight: FontWeight.w600,
                                ),
                                MyText(
                                  text: ' Account',
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
                                    'Fill all the information to create an account and use the app.',
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
                        const SizedBox(height: 32),
                        MyField(
                          controller: _fullName,
                          labelText: 'Full Name',
                          isName: true,
                          prefixIcon: SvgPicture.asset(
                            'assets/user.svg',
                            fit: BoxFit.scaleDown,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          validatorFunction: Common().validateField,
                        ),
                        const SizedBox(height: 16),
                        MyField(
                          controller: _email,
                          labelText: 'Email',
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
                        MyField(
                          controller: _password,
                          labelText: 'Password',
                          isPassword: true,
                          showPassword: showPassword,
                          prefixIcon: SvgPicture.asset(
                            'assets/password.svg',
                            fit: BoxFit.scaleDown,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          suffixIcon: MyButton(
                            function: () {
                              context.read<AuthBloc>().add(
                                    RegisterToggleShowPassword(),
                                  );
                            },
                            color: Colors.transparent,
                            width: 1.w,
                            child: SvgPicture.asset(
                              showPassword
                                  ? 'assets/showPassword.svg'
                                  : 'assets/hidePassword.svg',
                              fit: BoxFit.scaleDown,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                isDarkMode ? Colors.white : Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          validatorFunction: Common().validatePassword,
                        ),
                        const SizedBox(height: 16),
                        MyField(
                          controller: _confirmPassword,
                          labelText: 'Confirm Password',
                          isLast: true,
                          showPassword: showPassword,
                          isPassword: true,
                          prefixIcon: SvgPicture.asset(
                            'assets/password.svg',
                            fit: BoxFit.scaleDown,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              isDarkMode ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          suffixIcon: MyButton(
                            function: () {
                              context.read<AuthBloc>().add(
                                    RegisterToggleShowPassword(),
                                  );
                            },
                            color: Colors.transparent,
                            width: 1.w,
                            child: SvgPicture.asset(
                              showPassword
                                  ? 'assets/showPassword.svg'
                                  : 'assets/hidePassword.svg',
                              fit: BoxFit.scaleDown,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                isDarkMode ? Colors.white : Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          validatorFunction: validateConfirmPassword,
                        ),
                        const SizedBox(height: 32),
                        MyButton(
                          function: () {
                            if (_key.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    RegisterRequest(
                                      fullName: _fullName.text,
                                      email: _email.text.trim(),
                                      password: _password.text,
                                    ),
                                  );
                            }
                          },
                          height: 40,
                          width: 100.w,
                          color: Theme.of(context).colorScheme.primary,
                          disabled: state == RegisterLoading() ? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (state is RegisterLoading)
                                const Row(
                                  children: [
                                    LoadingIndicator(
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              SvgPicture.asset(
                                'assets/signIn.svg',
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 8),
                              const MyText(
                                text: 'Create account',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        MyButton(
                          function: () {
                            context
                                .read<AuthBloc>()
                                .add(GoogleSignInRequested());
                          },
                          color: Theme.of(context).colorScheme.surface,
                          width: 100.w,
                          height: 40,
                          border: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/google.svg',
                                height: 20,
                                width: 20,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 8),
                              const MyText(
                                text: 'Sign up with Google',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const MyText(
                              text: "Already have an account?",
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

  String? validateConfirmPassword(String? value) =>
      value == null || value.isEmpty
          ? 'This field is required'
          : value.length < 6
              ? 'Password must be longer than 6 characters'
              : _password.text != _confirmPassword.text
                  ? 'Passwords do not match'
                  : null;
}
