import 'package:flutter/material.dart';
import 'package:meal_app/proiders/language_provider.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../proiders/themes_provider.dart';
import '../screens/filters_screen.dart';
import '../screens/themes_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                lan.getTexts("drawer_name").toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildListTile(
                lan.getTexts("drawer_item1").toString(), Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            }, context),
            buildListTile(
                lan.getTexts("drawer_item2").toString(), Icons.settings, () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            buildListTile(
                lan.getTexts("drawer_item3").toString(), Icons.color_lens, () {
              Navigator.of(context)
                  .pushReplacementNamed(ThemesScreen.routeName);
            }, context),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
            const SizedBox(height: 10),
            Text(
              lan.getTexts("drawer_switch_title").toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lan.getTexts("drawer_switch_item2").toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Switch(
                  value: lan.isEn,
                  onChanged: (value) {
                    lan.changeLan(value);
                    Navigator.of(context).pop();
                  },
                  inactiveThumbColor:
                      Provider.of<ProviderTheme>(context, listen: true).tm ==
                              ThemeMode.light
                          ? null
                          : Colors.black,
                ),
                Text(
                  lan.getTexts('drawer_switch_item1').toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      String title, IconData icon, Function() tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyMedium!.color,
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
