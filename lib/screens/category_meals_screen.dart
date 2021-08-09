import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';


import 'package:meals_app/models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  final List<Meal> mealsList;

  CategoryMealsScreen(this.mealsList);

  /*
  Kreiranje ekrana preko funkcije! Bez rutes propertija u main.dart
  ali to se ne preporucuje kad su vece aplikacije u pitanju.

  final String catId;
  final String catTitle;

  CategoryMealsScreen(this.catId, this.catTitle);*/

  @override
  Widget build(BuildContext context) {
    final ruteArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = ruteArgs['id'];
    final categoryTitle = ruteArgs['title'].toString();
    final categoryMeals = mealsList.where((meal) => meal.categories.contains(categoryId)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              mealImageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
