import 'package:flutter/material.dart';
import 'package:flutter_course_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static final String routeName = "/filter-screen";
  final Function saveFilter;
  final Map<String, bool> currentFilter;
  FilterScreen({this.currentFilter, this.saveFilter});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  initState() {
    _glutenFree = widget.currentFilter["gluten"];
    _vegetarian = widget.currentFilter["vegetarian"];
    _vegan = widget.currentFilter["vegan"];
    _lactoseFree = widget.currentFilter["lactose"];
    super.initState();
  }

  Widget _buildSwitchListTile(
      {String title,
      String description,
      bool currentValue,
      Function updateValue}) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filters"),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  widget.saveFilter({
                    "gluten": _glutenFree,
                    "vegetarian": _vegetarian,
                    "vegan": _vegan,
                    "lactose": _lactoseFree,
                  });
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection.",
                style: (Theme.of(context).textTheme.headline6),
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    title: "Gluten Free",
                    description: 'Only include gluten-free meals.',
                    currentValue: _glutenFree,
                    updateValue: (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Lactose Free",
                    description: 'Only include lactose-free meals.',
                    currentValue: _lactoseFree,
                    updateValue: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Vegetarian Free",
                    description: 'Only include vegetarian meals.',
                    currentValue: _vegetarian,
                    updateValue: (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Vegan Free",
                    description: 'Only include vegan meals.',
                    currentValue: _vegan,
                    updateValue: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }),
              ],
            ))
          ],
        ));
  }
}
