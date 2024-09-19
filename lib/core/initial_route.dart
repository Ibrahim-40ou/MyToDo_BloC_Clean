import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_bloc/core/routes.dart';
import 'package:mytodo_bloc/main.dart';
import 'package:mytodo_bloc/presentation/widgets/loading_indicator.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        bool signedIn = signInCheck!.getString('signedIn') == null ||
                signInCheck!.getString('signedIn') == 'false'
            ? false
            : true;
        if (signedIn) {
          context.router.replaceAll([App()]);
        } else {
          context.router.replaceAll([SignIn()]);
        }
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: LoadingIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
