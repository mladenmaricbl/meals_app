import 'package:flutter/material.dart';

import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/models/meal.dart';

import '../dummy_data.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterMap){
      setState(() {
        _filters = filterMap;

        
        _availableMeals = DUMMY_MEALS.where((meal) {
         if((_filters['gluten'] ?? false) && !meal.isGlutenFree){
           return false;
         }
         if((_filters['lactose'] ?? false) && !meal.isLactoseFree){
           return false;
         }
         if((_filters['vegan'] ?? false) && !meal.isVegan){
           return false;
         }
         if((_filters['vegetarian'] ?? false) && !meal.isVegetarian){
           return false;
         }
         return true;
        }).toList();
      });

  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.textScaleFactorOf(context);

    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amberAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // home: TabsScreen(), ovako se moze isto umjesto home parametra napraviti home screen sa rutama!
      //initialRoute: CategoryScreen(), isto se moce napraviti home screen na ovaj nacin!
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals), // ovako se moze isto umjesto home parametra napraviti home screen sa rutama!
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      /*onGenerateRoute: (settings){
        //Ukoliko pokusavamo da odemo na neku nedefnisanu rutun onGenerateRoute se aktivira
        // i vrati recimo CategoryMealsScreen kao defaultni screen d an ebi doslo do errora.
        // Takodje ukoliko generisemo rute dinamicki mozemo da iskoritstimo argument name da izgenerisemo rutu.
        // Primjer koristenja:
        if(settings.name == '/meal-detail'){
          return ...;
        }else if(settings.name == '/somthing-else'){
          return ...;
        }
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      },*/
      onUnknownRoute: (settings){
        // UnknownRout se aktivira ukoliko flutter ne moze ispisati nista na ekranu.
        // Error 404 folback
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen(_availableMeals));
      },
    );
  }
}

