import 'package:daily_app/widgets/profile_pickture.dart';
import 'package:flutter/material.dart';
import '../themes/darkmode_theme.dart';
import '../themes/lightmode_theme.dart';
import '../themes/bluemode_theme.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';


class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Tema'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Tema Claro'),
            leading: Radio<ThemeData>(
              value: lightMode,
              groupValue: themeProvider.themeData,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  themeProvider.setTheme(value);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Tema Oscuro'),
            leading: Radio<ThemeData>(
              value: darkMode,
              groupValue: themeProvider.themeData,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  themeProvider.setTheme(value);
                }
              },
            ),
          ),
          ListTile(
            title: Text('Tema Azul'),
            leading: Radio<ThemeData>(
              value: blueMode,
              groupValue: themeProvider.themeData,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  themeProvider.setTheme(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
