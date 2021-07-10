import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final routeName = "/category-meals";
  final List<Meal> availableMeals;
  CategoryMealsScreen({this.availableMeals});
  @override
  State<StatefulWidget> createState() {
    return _CategoryMealsScreenState();
  }
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _isInitLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitLoading) {
      final routesArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String categoryId = routesArg["categoryId"];
      categoryTitle = routesArg["categoryTitle"];
      displayedMeals = widget.availableMeals.where((element) {
        return element.categories.contains(categoryId);
      }).toList();
      _isInitLoading = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) {
        return meal.id == mealId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: displayedMeals[index].title,
            id: displayedMeals[index].id,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
