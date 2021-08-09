import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String mealImageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    required this.id,
    required this.title,
    required this.mealImageUrl,
    required this.duration,
    required this.affordability,
    required this.complexity
  });

  String get complexityText{
    if(complexity == Complexity.Simple)
      return 'Simple';
    else if(complexity == Complexity.Challenging)
      return 'Challenging';
    else
      return 'Hard';
  }

  String get affordabilityText{
    if(affordability == Affordability.Affordable)
      return 'Affordable';
    else if(affordability == Affordability.Pricey)
      return 'Pricey';
    else
      return 'Luxurious';
  }

  void _openMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed( MealDetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => _openMeal(context),
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children:[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                  child: Image.network(mealImageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ]
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                     children: [
                       Icon(Icons.schedule),
                       SizedBox(
                         width: 6,
                       ),
                       Text(
                         '$duration minutes',
                       )
                     ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.construction),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '$complexityText',
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '$affordabilityText',
                        )
                      ],
                    )
                  ],
                ),
            ),
          ],
        ),
    ),
    );
  }
}
