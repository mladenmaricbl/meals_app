import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName =  '/filters';

  final Function saveFilters;
  Map<String, bool> _initFilters;

  FiltersScreen(this.saveFilters, this._initFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

    bool _isGlutenFree = false;
    bool _isVegan = false;
    bool _isVegetarian = false;
    bool _isLactoseFree = false;

    @override
    void initState() {
    _isGlutenFree = widget._initFilters['gluten'] ?? false;
    _isVegan = widget._initFilters['vegan'] ?? false;
    _isVegetarian = widget._initFilters['vegetarian'] ?? false;
    _isLactoseFree = widget._initFilters['lactose'] ?? false;

    super.initState();
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Adjust your meal section.',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                      value: _isGlutenFree,
                      title: Text('Gluten-free'),
                      subtitle: Text('Only include gluten-free meals.'),
                      onChanged: (newValue){
                          setState(() {
                            _isGlutenFree = newValue;
                           });
                      }),
                  SwitchListTile(
                      value: _isVegan,
                      title: Text('Vegan'),
                      subtitle: Text('Only include Vegan meals.'),
                      onChanged: (newValue){
                        setState(() {
                          _isVegan = newValue;
                        });
                       }),
                  SwitchListTile(
                      value: _isVegetarian,
                      title: Text('Vegetarian'),
                      subtitle: Text('Only include vegetarian meals.'),
                      onChanged: (newValue){
                        setState(() {
                          _isVegetarian = newValue;
                        });
                      }),
                  SwitchListTile(
                      value: _isLactoseFree,
                      title: Text('Lactorse-free'),
                      subtitle: Text('Only include lactose-free meals.'),
                      onChanged: (newValue){
                        setState(() {
                          _isLactoseFree = newValue;
                        });
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
            onPressed:(){
              final selectedFilters = {
                'gluten' : _isGlutenFree,
                'lactose' : _isLactoseFree,
                'vegan' : _isVegan,
                'vegetarian' : _isVegetarian,
              };
              widget.saveFilters(selectedFilters);
            }
        ),
      );
    }
}

