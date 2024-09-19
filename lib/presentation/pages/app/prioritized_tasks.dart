import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_bloc/presentation/bloc/app/app_bloc.dart';
import 'package:mytodo_bloc/presentation/pages/app/view_task.dart';
import 'package:mytodo_bloc/presentation/widgets/app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/slideable.dart';
import '../../widgets/text.dart';


// @RoutePage()
class PrioritizedTasks extends StatelessWidget {
  const PrioritizedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: MyAppBar(
              title: 'prioritized'.tr(),
              leadingExists: false,
            ),
            body: Builder(
              builder: (context) {
                if (state is FetchTasksLoading) {
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Shimmer.fromColors(
                            baseColor: const Color(0xFFCCCCCC),
                            highlightColor: Colors.white,
                            child: Container(
                              width: 100,
                              height: 12,
                              color: const Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                        subtitle: Shimmer.fromColors(
                          baseColor: const Color(0xFFCCCCCC),
                          highlightColor: Colors.white,
                          child: Container(
                            width: 200,
                            height: 12,
                            color: const Color(0xFFCCCCCC),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is FetchTasksSuccess) {
                  bool noTasks = state.tasks
                      .where((task) =>
                          task.status == 'pending' && task.prioritized)
                      .isEmpty;
                  if (state.tasks.isEmpty) {
                    return const Center(
                      child: MyText(text: 'you have no tasks.'),
                    );
                  }
                  if (noTasks) {
                    return const Center(
                      child: MyText(text: 'you have no prioritized tasks.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.tasks[index].prioritized == true &&
                          state.tasks[index].status == 'pending') {
                        return TaskListTile(
                          task: state.tasks[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewTask(
                                  task: state.tasks[index],
                                  editingMode: true,
                                ),
                              ),
                            );
                          },
                          completeTask: () {
                            context.read<AppBloc>().add(
                                  ChangeTaskStatusEvent(
                                    status: 'completed',
                                    task: state.tasks[index],
                                    index: index,
                                  ),
                                );
                          },
                          prioritizeTask: () {
                            context.read<AppBloc>().add(
                                  ChangeTaskPriorityEvent(
                                    prioritized: false,
                                    task: state.tasks[index],
                                    index: index,
                                  ),
                                );
                          },
                          changeTaskStatus: () {
                            context.read<AppBloc>().add(
                              ChangeTaskStatusEvent(
                                status: 'deleted',
                                task: state.tasks[index],
                                index: index,
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: MyText(text: 'error fetching tasks.'),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
