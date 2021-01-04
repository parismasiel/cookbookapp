import 'package:flutter/material.dart';
import 'package:mom_recipe_app/universal_widgets.dart';




class CookbookModel extends ChangeNotifier {





  CookbookModel({this.loadFunction}) {
      fetchLoad();
      }

  fetchLoad() async {
    _recipeList = await loadFunction();
    notifyListeners();
  }
  final Function loadFunction;
  final String bigListKey = 'LIST';
  List<Recipe> _recipeList = [];



  List<Recipe> get recipeList => _recipeList;

  deleteRecipeAt(int index) {
    _recipeList.removeAt(index);
    notifyListeners();
  }

  addRecipe(Recipe recipe) {
    _recipeList.add(recipe);
    notifyListeners();
  }

  setRecipeAt(Recipe recipe, int index) {
    _recipeList[index] = recipe;
    notifyListeners();
  }

  List<String> getRecipeDirections(int index) => _recipeList[index].directionsList;
  List<String> getRecipeIngredients(int index) => _recipeList[index].ingredientList;

  Recipe getRecipeAt(int index) => _recipeList[index];

  int get numberOfRecipes => _recipeList.length;
}


