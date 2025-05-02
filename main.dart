// lib/main.dart
// …imports…
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'themes/app_themes.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: (ctx) {
          final themeProvider = Provider.of<ThemeProvider>(ctx);
          return MaterialApp(
            title: 'DoDeck',
            theme: themeProvider.isDark ? Dark_Theme_Show : Light_Theme_Show,
            home: HomeScreen(),
            routes: {
              SettingsScreen.routeName: (_) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}