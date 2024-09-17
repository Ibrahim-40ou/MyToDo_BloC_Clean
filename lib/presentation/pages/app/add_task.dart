import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_bloc/core/common_functions.dart';
import 'package:mytodo_bloc/presentation/bloc/app/app_bloc.dart';
import 'package:mytodo_bloc/presentation/widgets/app_bar.dart';
import 'package:mytodo_bloc/presentation/widgets/button.dart';
import 'package:mytodo_bloc/presentation/widgets/loading_indicator.dart';

import '../../widgets/text.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController _body = TextEditingController();

  DateTime? _dateTime;

  bool _isPrioritized = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CheckTitleAndDateTimeState) {
          Common().showDialogue(
            context,
            'Make sure you have added the title and time to the task.',
            '',
            () {},
            () {},
          );
        }
        if (state is AppBack) {
          Common().showDialogue(
            context,
            '',
            'All data entered will be lost. Are you sure?',
            () {},
            () {
              Navigator.pop(context);
            },
          );
        }
        if (state is AddTaskSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is DateTimeSelected) {
          _dateTime = state.dateTime;
        }
        if (state is PriorityToggled) {
          _isPrioritized = state.isPrioritized;
        }
        return WillPopScope(
          onWillPop: () async {
            context.read<AppBloc>().add(AppBackPressed());
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: MyAppBar(
                title: 'Add Task',
                leadingExists: true,
                leadingFunction: () {
                  context.read<AppBloc>().add(AppBackPressed());
                },
              ),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _title,
                          textCapitalization: TextCapitalization.sentences,
                          style: GoogleFonts.cairo(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: GoogleFonts.cairo(
                              color: isDarkMode
                                  ? Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color
                                  : Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MyButton(
                              function: () {
                                context.read<AppBloc>().add(
                                      PickDateTime(context: context),
                                    );
                              },
                              height: 24,
                              width: 24,
                              color: Theme.of(context).colorScheme.surface,
                              child: SvgPicture.asset(
                                'assets/time.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            MyButton(
                              function: () {
                                context.read<AppBloc>().add(TogglePriority());
                              },
                              height: 24,
                              width: 24,
                              color: Theme.of(context).colorScheme.surface,
                              child: SvgPicture.asset(
                                _isPrioritized
                                    ? 'assets/prioritizedFilled.svg'
                                    : 'assets/prioritized.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _dateTime != null
                                ? Container(
                                    margin: EdgeInsets.zero,
                                    height: 24,
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      bottom: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 1,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                      ),
                                    ),
                                    child: Center(
                                      child: MyText(
                                        text: DateFormat('EEE, MMM d, h:mm a')
                                            .format(
                                          _dateTime!,
                                        ),
                                        size: 14,
                                        weight: FontWeight.normal,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _body,
                      style: GoogleFonts.cairo(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: GoogleFonts.cairo(
                          color: isDarkMode
                              ? Theme.of(context).textTheme.labelMedium!.color
                              : Theme.of(context).textTheme.labelMedium!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<AppBloc>().add(
                        AddTask(
                          title: _title.text,
                          body: _body.text,
                          prioritized: _isPrioritized,
                          status: 'pending',
                          dateTime: _dateTime,
                        ),
                      );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Builder(
                  builder: (context) {
                    if (state is AddTaskLoading) {
                      return const LoadingIndicator(color: Colors.white);
                    } else {
                      return SvgPicture.asset(
                        'assets/save.svg',
                        height: 20,
                        width: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
