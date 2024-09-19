import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodo_bloc/presentation/widgets/text_field.dart';
import 'package:mytodo_bloc/core/sizeConfig.dart';

import '../../../core/common_functions.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text.dart';

@RoutePage()
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
            'are you sure you want to leave? all data entered will be lost.',
            () {},
            () {
              context.router.popForced(true);
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  text: 'forgot',
                                  size: 26,
                                  weight: FontWeight.w600,
                                ),
                                MyText(
                                  text: ' password',
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
                                    'enter the email address that corresponds with your account.',
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
                          labelText: 'email'.tr(),
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
                                text: 'send',
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
                              text: "remembered your password",
                              size: 16,
                              weight: FontWeight.normal,
                            ),
                            MyButton(
                              height: 3.h,
                              function: () {
                                context.router.popForced(true);
                              },
                              color: Theme.of(context).colorScheme.surface,
                              child: MyText(
                                text: 'sign in',
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
