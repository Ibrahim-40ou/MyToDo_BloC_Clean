import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodo_bloc/presentation/bloc/auth/auth_bloc.dart';
import 'package:mytodo_bloc/presentation/widgets/button.dart';
import 'package:mytodo_bloc/presentation/widgets/loading_indicator.dart';
import 'package:mytodo_bloc/core/sizeConfig.dart';
import 'package:mytodo_bloc/core/routes.dart';
import '../../../core/common_functions.dart';
import '../../widgets/text.dart';
import '../../widgets/text_field.dart';

@RoutePage()
class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          Common().showDialogue(
            context,
            state.message,
            '',
            () {},
            () {},
          );
        }
        if (state is SignInSuccess || state is GoogleSignInSuccess) {
          context.router.push(const InitialRoute());
        }
      },
      builder: (context, state) {
        bool isArabic = Localizations.localeOf(context).toString() == 'en_US' ? false : true;
        bool showPassword = true;
        if (state is SignInShowPasswordToggled) {
          showPassword = state.showPassword;
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logo.svg'),
                          const SizedBox(width: 16),
                          MyText(
                            text: isArabic ? 'ToDo' : 'My',
                            size: 26,
                            weight: FontWeight.w600,
                            color: isArabic
                                ? Theme.of(context).textTheme.bodyMedium!.color!
                                : Theme.of(context).colorScheme.primary,
                          ),
                          MyText(
                            text: isArabic ? 'My' : 'ToDo',
                            size: 26,
                            weight: FontWeight.w600,
                            color: isArabic
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!,
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const MyText(
                                text: 'welcome back to',
                                size: 24,
                                weight: FontWeight.w600,
                                overflow: TextOverflow.visible,
                              ),
                              MyText(
                                text: ' my',
                                size: 24,
                                weight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                                overflow: TextOverflow.visible,
                              ),
                              const MyText(
                                text: 'todo',
                                size: 24,
                                weight: FontWeight.w600,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                          MyText(
                            text:
                                'enter your email address and password to continue and use the app.',
                            size: 14,
                            color: isDarkMode
                                ? Theme.of(context).textTheme.bodyMedium?.color
                                : Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.color,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      MyField(
                        controller: _email,
                        labelText: 'email'.tr(),
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
                        labelText: 'password'.tr(),
                        isLast: true,
                        isPassword: true,
                        showPassword: showPassword,
                        prefixIcon: SvgPicture.asset(
                          fit: BoxFit.scaleDown,
                          'assets/password.svg',
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            isDarkMode ? Colors.white : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        suffixIcon: MyButton(
                          function: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInToggleShowPassword());
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
                      const SizedBox(height: 4),
                      MyButton(
                        width: 40.w,
                        height: 40,
                        function: () {
                          context.router.push(ForgotPassword());
                        },
                        color: Theme.of(context).colorScheme.surface,
                        child: const MyText(
                          text: 'forgot password',
                        ),
                      ),
                      const SizedBox(height: 4),
                      MyButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignInRequest(
                                    email: _email.text.trim(),
                                    password: _password.text,
                                  ),
                                );
                          }
                        },
                        disabled: state == SignInLoading() ? true : false,
                        color: Theme.of(context).colorScheme.primary,
                        width: 100.w,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (state is SignInLoading)
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
                              text: 'sign in',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButton(
                        function: () {
                          context.read<AuthBloc>().add(GoogleSignInRequested());
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
                              text: 'sign in with google',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const MyText(
                            text: "don't have an account",
                            size: 16,
                            weight: FontWeight.normal,
                          ),
                          MyButton(
                            height: 3.h,
                            function: () {
                              context.router.push(Register());
                            },
                            color: Theme.of(context).colorScheme.surface,
                            child: MyText(
                              text: 'register',
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
        );
      },
    );
  }
}
