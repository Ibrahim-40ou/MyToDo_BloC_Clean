import 'package:flutter/material.dart';
import 'package:mytodo_bloc/presentation/widgets/text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leadingExists;
  final bool actionExists;
  final VoidCallback? leadingFunction;
  final VoidCallback? actionFunction;
  final String? actionIcon;

  const MyAppBar({
    super.key,
    required this.title,
    required this.leadingExists,
    this.actionExists = false,
    this.leadingFunction,
    this.actionFunction,
    this.actionIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.secondary,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 1,
      titleSpacing: leadingExists ? 0 : 16,
      title: MyText(
        text: title,
        size: 22,
        weight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyMedium!.color!,
      ),
      leading: leadingExists
          ? IconButton(
              onPressed: leadingFunction ?? () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
      actions: actionExists
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: actionFunction!,
                  child: Image.asset(actionIcon!),
                ),
              ),
            ]
          : null,
    );
  }
}
