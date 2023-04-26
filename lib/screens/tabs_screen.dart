import 'package:flutter/material.dart';
import 'package:meal_app/proiders/themes_provider.dart';
import 'package:provider/provider.dart';

import '../proiders/language_provider.dart';
import '../proiders/meal_provider.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const routeName = '/';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    Provider.of<ProviderMeal>(context, listen: false).getData();
    Provider.of<ProviderTheme>(context, listen: false).getThemeMode();
    Provider.of<ProviderTheme>(context, listen: false).getThemeColors();

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': lan.getTexts("categories").toString(),
      },
      {
        'page': FavoritesScreen(),
        'title': lan.getTexts("your_favorites").toString(),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'].toString()),
        ),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
              label: lan.getTexts('categories').toString(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.star),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
