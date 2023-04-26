import 'package:flutter/material.dart';
import 'package:meal_app/proiders/language_provider.dart';
import 'package:meal_app/proiders/themes_provider.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import 'proiders/meal_provider.dart';
import 'screens/themes_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderMeal>(
          create: (BuildContext context) => ProviderMeal(),
        ),
        ChangeNotifierProvider<ProviderTheme>(
          create: (BuildContext context) => ProviderTheme(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (BuildContext context) => LanguageProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ProviderTheme>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ProviderTheme>(context, listen: true).accentColor;
    var tm = Provider.of<ProviderTheme>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
        cardColor: Colors.white,
        shadowColor: Colors.black54,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleMedium: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        cardColor: const Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white70,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.white70),
        textTheme: ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleMedium: const TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => const TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => const FiltersScreen(),
        ThemesScreen.routeName: (ctx) => const ThemesScreen(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoriesScreen(),
        );
      },
    );
  }
}
