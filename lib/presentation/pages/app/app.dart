import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_bloc/presentation/pages/app/prioritized_tasks.dart';
import 'package:mytodo_bloc/presentation/pages/app/settings.dart';
import 'package:mytodo_bloc/presentation/pages/app/tasks.dart';
import '../../bloc/app/cubit/navigation_bar_cubit.dart';


@RoutePage()
class App extends StatelessWidget {
  App({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<NavigationCubit, int>(
            builder: (context, currentIndex) {
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<NavigationCubit>().changePage(index);
                },
                children: _pageViewItems,
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            builder: (context, currentIndex) {
              return BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Theme.of(context).colorScheme.surface,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.easeInOut,
                  );
                  context.read<NavigationCubit>().changePage(index);
                },
                currentIndex: currentIndex,
                items: _buildNavigationBarItems(context),
                selectedLabelStyle: GoogleFonts.cairo(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.normal,
                ),
                unselectedLabelStyle: GoogleFonts.cairo(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.normal,
                ),
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ),
      ),
    );
  }

  final List<Widget> _pageViewItems = [
    const Tasks(),
    const PrioritizedTasks(),
    const Settings(),
  ];

  List<BottomNavigationBarItem> _buildNavigationBarItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/tasks.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        activeIcon: SvgPicture.asset(
          'assets/tasksFilled.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        label: 'Tasks',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/prioritized.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        activeIcon: SvgPicture.asset(
          'assets/prioritizedFilled.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        label: 'Prioritized Tasks',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/settings.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        activeIcon: SvgPicture.asset(
          'assets/settingsFilled.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        label: 'Settings',
      ),
    ];
  }
}
