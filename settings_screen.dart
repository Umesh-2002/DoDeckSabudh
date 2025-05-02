// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';



class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title:Text('Settings')),
      body: ListTile(
        title: Text('Dark Theme'),
        trailing: Switch(
          value: themeProv.isDark,
          onChanged:(_)=>themeProv.toggleTheme(),
        ),
      ),
    );
  }
}
