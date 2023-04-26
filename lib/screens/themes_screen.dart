import 'package:flutter/material.dart';
import 'package:meal_app/proiders/language_provider.dart';
import 'package:meal_app/proiders/themes_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themes';
  final bool fromOnBoarding;
  const ThemesScreen({super.key, this.fromOnBoarding = false});

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue(),
      inactiveTrackColor: Colors.black,
    );
  }

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData? icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(ctx).buttonColor),
      value: themeVal,
      groupValue: Provider.of<ProviderTheme>(ctx, listen: true).tm,
      onChanged: (newThemeVal) => Provider.of<ProviderTheme>(ctx, listen: false)
          .themeModeChange(newThemeVal),
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      appBar: fromOnBoarding
          ? AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
            )
          : AppBar(
              title: Text(lan.getTexts("theme_appBar_title").toString()),
            ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              lan.getTexts("theme_screen_title").toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts("theme_mode_title").toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                buildRadioListTile(
                    ThemeMode.system,
                    lan.getTexts("System_default_theme").toString(),
                    null,
                    context),
                buildRadioListTile(
                    ThemeMode.light,
                    lan.getTexts("light_theme").toString(),
                    Icons.wb_sunny_outlined,
                    context),
                buildRadioListTile(
                    ThemeMode.dark,
                    lan.getTexts("dark_theme").toString(),
                    Icons.nights_stay_outlined,
                    context),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent'),
                SizedBox(
                  height: fromOnBoarding ? 80 : 0,
                )
              ],
            ),
          )
        ],
      ),
      drawer: fromOnBoarding ? null : const MainDrawer(),
    );
  }

  ListTile buildListTile(BuildContext context, txt) {
    var primaryColor =
        Provider.of<ProviderTheme>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ProviderTheme>(context, listen: true).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return ListTile(
      title: Text(
        txt == 'primary'
            ? lan.getTexts("primary").toString()
            : lan.getTexts("accent").toString(),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 4,
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: txt == "primary"
                      ? Provider.of<ProviderTheme>(context, listen: true)
                          .primaryColor
                      : Provider.of<ProviderTheme>(context, listen: true)
                          .accentColor,
                  onColorChanged: (newColor) =>
                      Provider.of<ProviderTheme>(context, listen: false)
                          .onChanged(newColor, txt == "primary" ? 1 : 2),
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
