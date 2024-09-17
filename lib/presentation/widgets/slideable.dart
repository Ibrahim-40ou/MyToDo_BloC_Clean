import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:mytodo_bloc/presentation/widgets/text.dart';
import 'package:sizer/sizer.dart';

class TaskListTile extends StatelessWidget {
  final TaskEntity task;
  final bool isContained;
  final VoidCallback onTap;
  final Function? completeTask;
  final Function? changeTaskStatus;
  final Function? prioritizeTask;
  final Function? deleteTask;

  const TaskListTile({
    super.key,
    required this.onTap,
    required this.task,
    this.isContained = false,
    this.completeTask,
    this.changeTaskStatus,
    this.prioritizeTask,
    this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isContained
            ? Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
      ),
      child: Slidable(
        startActionPane: task.status == 'completed'
            ? null
            : task.status == 'deleted'
                ? ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          if (changeTaskStatus != null) {
                            changeTaskStatus!();
                          }
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        icon: CupertinoIcons.arrow_left,
                      ),
                    ],
                  )
                : ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          if (completeTask != null) {
                            completeTask!();
                          }
                        },
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        icon: CupertinoIcons.checkmark_alt,
                      ),
                    ],
                  ),
        endActionPane: task.status != 'pending' ? ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                if (deleteTask != null) {
                  deleteTask!();
                }
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              icon: CupertinoIcons.delete,
            ),
          ],
        ) : ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                if (changeTaskStatus != null) {
                  changeTaskStatus!();
                }
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              icon: CupertinoIcons.delete,
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                if (prioritizeTask != null) {
                  prioritizeTask!();
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: task.status == 'pending' && task.prioritized
                  ? CupertinoIcons.arrow_left
                  : CupertinoIcons.star,
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 75.w,
                child: MyText(
                  text: task.title,
                  size: 18,
                  weight: FontWeight.w600,
                  color: isContained
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium!.color!,
                ),
              ),
              MyText(
                text: formatCustomDateTime(task.date_time),
                size: 12,
                weight: FontWeight.w400,
                color: isContained
                    ? Colors.white
                    : Theme.of(context).textTheme.labelMedium!.color!,
              ),
            ],
          ),
          subtitle: MyText(
            text: task.body,
            size: 14,
            weight: FontWeight.normal,
            color: isContained
                ? Colors.white
                : Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          tileColor: isContained ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
    );
  }

  String formatCustomDateTime(String dateTimeString) {
    DateTime now = DateTime.now();
    DateTime startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    DateTime endOfWeek = DateTime.now()
        .subtract(Duration(days: DateTime.now().weekday - 1))
        .add(const Duration(days: 7));
    DateTime dateTime = DateTime.parse(dateTimeString);
    if (DateFormat('yyyy-MM-dd').format(dateTime) ==
        DateFormat('yyyy-MM-dd').format(now)) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (dateTime.isAfter(startOfWeek) && dateTime.isBefore(endOfWeek)) {
      return DateFormat('EEE').format(dateTime);
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}
