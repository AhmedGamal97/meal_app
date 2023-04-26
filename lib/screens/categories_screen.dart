import 'package:flutter/material.dart';
import 'package:meal_app/proiders/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: Provider.of<ProviderMeal>(context)
          .availableCategory
          .map(
            (catData) => CategoryItem(
              catData.id,
              catData.color,
            ),
          )
          .toList(),
    );
  }
}
