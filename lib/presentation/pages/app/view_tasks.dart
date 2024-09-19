import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_bloc/presentation/bloc/app/app_bloc.dart';
import 'package:mytodo_bloc/presentation/pages/app/view_task.dart';
import 'package:mytodo_bloc/presentation/widgets/app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/slideable.dart';
import '../../widgets/text.dart';


@RoutePage()
class ViewTasks extends StatelessWidget {
  final String page;

  const ViewTasks({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: MyAppBar(
              title: page == 'completed' ? 'completed tasks'.tr() : 'deleted tasks'.tr(),
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
                  bool noTasks =
                      state.tasks.where((task) => task.status == page).isEmpty;
                  if (state.tasks.isEmpty) {
                    return Center(
                      child: MyText(
                        text: page == 'completed'
                            ? 'you have no completed tasks.'
                            : 'you have no deleted tasks.',
                      ),
                    );
                  }
                  if (noTasks) {
                    return Center(
                      child: MyText(
                        text: page == 'completed'
                            ? 'you have no completed tasks.'
                            : 'you have no deleted tasks.',
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.tasks[index].status == page) {
                        return TaskListTile(
                          task: state.tasks[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewTask(
                                  task: state.tasks[index],
                                  editingMode: false,
                                ),
                              ),
                            );
                          },
                          deleteTask: () {
                            context.read<AppBloc>().add(
                                  DeleteTaskEvent(task: state.tasks[index]),
                                );
                          },
                          changeTaskStatus: () {
                            context.read<AppBloc>().add(
                                  ChangeTaskStatusEvent(
                                    status: 'pending',
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
