import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodo_bloc/core/common_functions.dart';
import 'package:mytodo_bloc/presentation/bloc/app/app_bloc.dart';
import 'package:mytodo_bloc/presentation/pages/app/view_tasks.dart';
import 'package:mytodo_bloc/presentation/pages/auth/sign_in.dart';
import 'package:mytodo_bloc/presentation/widgets/app_bar.dart';
import 'package:mytodo_bloc/presentation/widgets/button.dart';
import 'package:mytodo_bloc/presentation/widgets/loading_indicator.dart';
import 'package:mytodo_bloc/presentation/widgets/settings_card.dart';
import 'package:mytodo_bloc/presentation/widgets/text.dart';
import 'package:sizer/sizer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SignOutLoading) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: LoadingIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        }
        if (state is SignOutFailure) {
          Common().showDialogue(
            context,
            state.message,
            '',
            () {},
            () {},
          );
        }
        if (state is SignOutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: const MyAppBar(
              title: 'Settings',
              leadingExists: false,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SettingsCard(
                        label: 'Theme',
                        text: 'Light',
                        icon: SvgPicture.asset(
                          isDarkMode
                              ? 'assets/light.svg'
                              : 'assets/lightFilled.svg',
                          height: 24,
                          width: 24,
                        ),
                        function: () {
                          context
                              .read<AppBloc>()
                              .add(ChangeTheme(isDarkMode: false));
                        },
                        buttonColor: isDarkMode
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                        textsColor: isDarkMode
                            ? Theme.of(context).textTheme.bodyMedium!.color!
                            : Colors.white,
                      ),
                      SettingsCard(
                        label: 'Theme',
                        text: 'Dark',
                        icon: SvgPicture.asset(
                          isDarkMode
                              ? 'assets/darkFilled.svg'
                              : 'assets/dark.svg',
                          height: 24,
                          width: 24,
                        ),
                        function: () {
                          context
                              .read<AppBloc>()
                              .add(ChangeTheme(isDarkMode: true));
                        },
                        buttonColor: isDarkMode
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        textsColor: isDarkMode
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  MyButton(
                    width: 100.w,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ViewTasks(page: 'completed'),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 38.5.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/completed.svg',
                                height: 22,
                                width: 22,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const MyText(text: 'Completed Tasks'),
                            ],
                          ),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 24,
                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    width: 100.w,
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ViewTasks(page: 'deleted'),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 34.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/delete.svg',
                                height: 28,
                                width: 28,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const MyText(text: 'Deleted Tasks'),
                            ],
                          ),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 24,
                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    width: 100.w,
                    function: () {
                      context.read<AppBloc>().add(SignOutRequested());
                    },
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 24.5.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/signOut.svg',
                                height: 22,
                                width: 22,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const MyText(text: 'Sign Out'),
                            ],
                          ),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 24,
                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
