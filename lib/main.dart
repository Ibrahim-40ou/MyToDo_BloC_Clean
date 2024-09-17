import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_bloc/presentation/bloc/app/app_bloc.dart';
import 'package:mytodo_bloc/presentation/pages/app/app.dart';
import 'package:mytodo_bloc/presentation/pages/auth/sign_in.dart';
import 'package:mytodo_bloc/core/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/bloc/auth/auth_bloc.dart';

SharedPreferences? signInCheck;
SharedPreferences? darkModeCheck;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oonuqdnkoghbrcxfytyj.supabase.co/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vbnVxZG5rb2doYnJjeGZ5dHlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2Mjc4MTEsImV4cCI6MjAzOTIwMzgxMX0.g-DoCRQcuIcVYKbZTI-bX1so8xMcWZWD5CfHF6J1gkM',
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  signInCheck = await SharedPreferences.getInstance();
  darkModeCheck = await SharedPreferences.getInstance();

  bool isDarkMode = darkModeCheck?.getBool('isDarkMode') ?? false;

  runApp(
    Sizer(
      builder: (context, orientation, screenType) {

        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(),
            ),
            BlocProvider<AppBloc>(
              create: (context) =>
                  AppBloc()..add(LoadTheme(isDarkMode: isDarkMode)),
            ),
          ],
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              final isDarkMode = state is ThemeChanged
                  ? state.isDarkMode
                  : darkModeCheck?.getBool('isDarkMode') ?? false;

              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  systemNavigationBarColor: isDarkMode
                      ? const Color(0xFF05040B)
                      : const Color(0xFFF5F4FB),
                  systemNavigationBarIconBrightness:
                      isDarkMode ? Brightness.light : Brightness.dark,
                  statusBarColor: isDarkMode
                      ? const Color(0xFF05040B)
                      : const Color(0xFFF5F4FB),
                  statusBarBrightness:
                      isDarkMode ? Brightness.dark : Brightness.light,
                  statusBarIconBrightness:
                      isDarkMode ? Brightness.light : Brightness.dark,
                ),
              );
              return MaterialApp(
                theme: light,
                darkTheme: dark,
                themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: signInCheck!.getString('signedIn') == null ||
                        signInCheck!.getString('signedIn') == 'false'
                    ? SignIn()
                    : App(),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.0),
                    ),
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    ),
  );
}
