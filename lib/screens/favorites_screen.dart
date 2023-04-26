import 'package:flutter/material.dart';
import 'package:meal_app/proiders/language_provider.dart';
import 'package:meal_app/proiders/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final List<Meal> favoriteMeals =
        Provider.of<ProviderMeal>(context, listen: true).favoriteMeals;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(lan.getTexts('favorites_text').toString()),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: isLandscape ? dw / (dw * 0.8) : dw / (dw * 0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
