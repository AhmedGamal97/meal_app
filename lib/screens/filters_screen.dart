// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:meal_app/proiders/language_provider.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/proiders/themes_provider.dart';

import '../proiders/meal_provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;
  const FiltersScreen({
    Key? key,
    this.fromOnBoarding = false,
  }) : super(key: key);

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue, BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ProviderTheme>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<ProviderMeal>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts("filters_appBar_title").toString()),
              ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                lan.getTexts("filters_screen_title").toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      lan.getTexts("Gluten-free").toString(),
                      lan.getTexts("Gluten-free-sub").toString(),
                      currentFilters['gluten']!, (newValue) {
                    currentFilters['gluten'] = newValue;
                    Provider.of<ProviderMeal>(context, listen: false)
                        .setFilters();
                  }, context),
                  _buildSwitchListTile(
                      lan.getTexts("Lactose-free").toString(),
                      lan.getTexts("Lactose-free_sub").toString(),
                      currentFilters['lactose']!, (newValue) {
                    currentFilters['lactose'] = newValue;
                    Provider.of<ProviderMeal>(context, listen: false)
                        .setFilters();
                  }, context),
                  _buildSwitchListTile(
                      lan.getTexts("Vegetarian").toString(),
                      lan.getTexts("Vegetarian-sub").toString(),
                      currentFilters['vegetarian']!, (newValue) {
                    currentFilters['vegetarian'] = newValue;
                    Provider.of<ProviderMeal>(context, listen: false)
                        .setFilters();
                  }, context),
                  _buildSwitchListTile(
                      lan.getTexts("Vegan").toString(),
                      lan.getTexts("Vegan-sub").toString(),
                      currentFilters['vegan']!, (newValue) {
                    currentFilters['vegan'] = newValue;
                    Provider.of<ProviderMeal>(context, listen: false)
                        .setFilters();
                  }, context)
                ],
              ),
            ),
            SizedBox(
              height: fromOnBoarding ? 80 : 0,
            )
          ],
        ),
        drawer: fromOnBoarding ? null : MainDrawer(),
      ),
    );
  }
}
