import 'package:flutter/material.dart';
import 'package:flutter_course_app/models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen({this.favouriteMeals});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': "Categories"},
      {
        'page': FavouritesScreen(
          favouriteMeals: widget.favouriteMeals,
        ),
        'title': "Favourites"
      }
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> _selectedPage = _pages[_selectedPageIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage["title"]),
      ),
      drawer: MainDrawer(),
      body: _selectedPage["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _selectPage(value),
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
