import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _listOfFavorites;

  FavoritesScreen(this._listOfFavorites);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listOfFavorites.isEmpty ?
      Center(
          child:Text(
              'You don\'t have favorite meals yet!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
      )
          :
      ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: _listOfFavorites[index].id,
              title: _listOfFavorites[index].title,
              mealImageUrl: _listOfFavorites[index].imageUrl,
              duration: _listOfFavorites[index].duration,
              affordability: _listOfFavorites[index].affordability,
              complexity: _listOfFavorites[index].complexity
          );
        },
        itemCount: _listOfFavorites.length,
      ),
    );
  }
}
