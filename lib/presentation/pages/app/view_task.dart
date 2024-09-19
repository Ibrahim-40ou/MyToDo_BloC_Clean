import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';

import '../../../core/common_functions.dart';
import '../../bloc/app/app_bloc.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text.dart';

@RoutePage()
class ViewTask extends StatefulWidget {
  final TaskEntity task;
  final bool editingMode;

  const ViewTask({
    super.key,
    required this.task,
    required this.editingMode,
  });

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  late TextEditingController _title;
  late TextEditingController _body;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.task.title);
    _body = TextEditingController(text: widget.task.body);
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
    Theme
        .of(context)
        .brightness == Brightness.dark ? true : false;

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CheckTitleAndDateTimeState) {
          Common().showDialogue(
            context,
            'make sure you have added the title and time to the task.',
            '',
                () {},
                () {},
          );
        }
        if (state is AppBack && widget.editingMode) {
          Common().showDialogue(
            context,
            '',
            'all new edits will be lost. are you sure?',
                () {},
                () {
              context.router.popForced(true);
            },
          );
        }
        if (state is UpdateTaskSuccess) {
          context.router.popForced(true);
        }
      },
      builder: (context, state) {
        if (state is DateTimeSelected) {
          if (state.dateTime != null) {
            widget.task.date_time =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(state.dateTime!);
          }
        }
        if (state is PriorityToggled) {
          widget.task.prioritized = state.isPrioritized;
        }

        return WillPopScope(
          onWillPop: () async {
            widget.editingMode
                ? context.read<AppBloc>().add(AppBackPressed())
                : context.router.popForced(true);
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: MyAppBar(
                title: widget.editingMode ? 'edit task' : 'view task',
                leadingExists: true,
                leadingFunction: () {
                  widget.editingMode
                      ? context.read<AppBloc>().add(AppBackPressed())
                      : context.router.popForced(true);
                },
              ),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: widget.editingMode,
                          controller: _title,
                          textCapitalization: TextCapitalization.sentences,
                          style: GoogleFonts.cairo(
                            color:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'title'.tr(),
                            hintStyle: GoogleFonts.cairo(
                              color: isDarkMode
                                  ? Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color
                                  : Theme
                                  .of(context)
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
                              disabled: !widget.editingMode,
                              height: 24,
                              width: 24,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .surface,
                              child: SvgPicture.asset(
                                'assets/time.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            MyButton(
                              function: () {
                                context.read<AppBloc>().add(TogglePriority());
                              },
                              disabled: !widget.editingMode,
                              height: 24,
                              width: 24,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .surface,
                              child: SvgPicture.asset(
                                widget.task.prioritized
                                    ? 'assets/prioritizedFilled.svg'
                                    : 'assets/prioritized.svg',
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
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
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                ),
                              ),
                              child: Center(
                                child: MyText(
                                  text: DateFormat('EEE, MMM d, h:mm a').format(
                                    DateTime.parse(widget.task.date_time),
                                  ),
                                  size: 14,
                                  weight: FontWeight.normal,
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      enabled: widget.editingMode,
                      controller: _body,
                      style: GoogleFonts.cairo(
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'description'.tr(),
                        hintStyle: GoogleFonts.cairo(
                          color: isDarkMode
                              ? Theme
                              .of(context)
                              .textTheme
                              .labelMedium!
                              .color
                              : Theme
                              .of(context)
                              .textTheme
                              .labelMedium!
                              .color,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: widget.editingMode
                  ? FloatingActionButton(
                onPressed: () {
                  context.read<AppBloc>().add(
                    UpdateTaskEvent(
                      task: TaskEntity(
                        user_id: widget.task.user_id,
                        task_id: widget.task.task_id,
                        title: _title.text,
                        body: _body.text,
                        prioritized: widget.task.prioritized,
                        status: widget.task.status,
                        date_time: widget.task.date_time,
                      ),
                    ),
                  );
                },
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                child: Builder(
                  builder: (context) {
                    if (state is UpdateTaskLoading) {
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
              )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
