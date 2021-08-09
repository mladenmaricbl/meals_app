import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favorites;

  TabsScreen(this._favorites);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List <Widget> _tabScreens;
  final List <String> _tabScreenTitles = ['Categories', 'Your Favorites'];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _tabScreens = [
      CategoryScreen(),
      FavoritesScreen(widget._favorites),
    ];
    super.initState();
  }
  void _selectePage(int index){
      setState(() {
        _selectedPageIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
/* na ovaj nacin se dodaje tab al u gornjem dijelu aplikacije sto za ovu aplikaciju mi je malo ruzno
    pa cemo ga dodati na dno.

   return DefaultTabController(
        length: 2,
        //initialIndex: 0, ovim parametrom podesavamo koji ce se tab prikazati inicijalno!
        child: Scaffold(
          appBar: AppBar(title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Caegories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
          ),
          body: TabBarView(
            children: [
              CategoryScreen(),
              FavoritesScreen(),
            ],
          ),
        ),
    );*/
  return Scaffold(
    appBar: AppBar(title: Text(_tabScreenTitles[_selectedPageIndex]),
    ),
    drawer: MainDrawer(),
    body: _tabScreens[_selectedPageIndex],
    bottomNavigationBar: BottomNavigationBar(
      onTap: _selectePage,
      //backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: _selectedPageIndex,
      type: BottomNavigationBarType.shifting,
      selectedFontSize: 15,
      // kada imamo type: BottomNavigationBarType.shifting moramo dodati i parametre za svaki item u tabu umjesto na sam tab.
      items: [
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.construction),
            title: Text('Categories'),
        ),
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
        )
      ],
    ),
  );
  }
}
