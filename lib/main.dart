import 'package:flutter/material.dart';
import 'package:mom_recipe_app/models/cookbook_model.dart';
import 'package:provider/provider.dart';
import 'universal_widgets.dart';
import 'package:mom_recipe_app/ui/home_screen.dart';
import 'dart:io';
import 'constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> recipeDatabase = openDatabase(
        join(await getDatabasesPath(), 'recipeDatabase10.db'),
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE recipeStringTable(id INTEGER PRIMARY KEY, title STRING, picture STRING, prepTime INTEGER, cookTime INTEGER, "
                "totalTime INTEGER, description STRING)",
          );
          await db.execute(
            "CREATE TABLE recipeIngredientsTable(recipeId INTEGER PRIMARY KEY, ingredientZero STRING, ingredientOne STRING, ingredientTwo STRING, ingredientThree STRING, ingredientFour STRING, "
                "ingredientFive STRING, ingredientSix STRING, ingredientSeven STRING, ingredientEight STRING, ingredientNine STRING, ingredientTen STRING,"
                "ingredientEleven STRING, ingredientTwelve STRING, ingredientThirteen STRING, ingredientFourteen STRING)",
          );
          await db.execute(
            "CREATE TABLE recipeDirectionsTable(recipeId INTEGER PRIMARY KEY, directionZero STRING, directionOne STRING, directionTwo STRING, directionThree STRING, directionFour STRING, "
                "directionFive STRING, directionSix STRING, directionSeven STRING, directionEight STRING, directionNine STRING, directionTen STRING, "
                "directionEleven STRING, directionTwelve STRING, directionThirteen STRING, directionFourteen STRING)",
          );
        },
        version : 1
    );



  List<String> ingredientToList(Map<String, dynamic> map) {
    List<String> ingredientList = List(15);
    ingredientList[0] = map['ingredientZero'];
    ingredientList[1] = map['ingredientOne'];
    ingredientList[2] = map['ingredientTwo'];
    ingredientList[3] = map['ingredientThree'];
    ingredientList[4] = map['ingredientFour'];
    ingredientList[5] = map['ingredientFive'];
    ingredientList[6] = map['ingredientSix'];
    ingredientList[7] = map['ingredientSeven'];
    ingredientList[8] = map['ingredientEight'];
    ingredientList[9] = map['ingredientNine'];
    ingredientList[10] = map['ingredientTen'];
    ingredientList[11] = map['ingredientEleven'];
    ingredientList[12] = map['ingredientTwelve'];
    ingredientList[13] = map['ingredientThirteen'];
    ingredientList[14] = map['ingredientFourteen'];

   // ingredientList.removeWhere((value) => value == null);
    return ingredientList;

  }





  List<String> directionsToList(Map<String, dynamic> map) {
    List<String> directionsList = List(15);
    directionsList[0] = map['directionZero'];
    directionsList[1] = map['directionOne'];
    directionsList[2] = map['directionTwo'];
    directionsList[3] = map['directionThree'];
    directionsList[4] = map['directionFour'];
    directionsList[5] = map['directionFive'];
    directionsList[6] = map['directionSix'];
    directionsList[7] = map['directionSeven'];
    directionsList[8] = map['directionEight'];
    directionsList[9] = map['directionNine'];
    directionsList[10] = map['directionTen'];
    directionsList[11] = map['directionEleven'];
    directionsList[12] = map['directionTwelve'];
    directionsList[13] = map['directionThirteen'];
    directionsList[14] = map['directionFourteen'];


   // directionsList.removeWhere((value) => value == null);
    return directionsList;

  }





  Future<List<Recipe>> loadRecipesFromDatabase() async {
    // Get a reference to the database.
    final Database db = await recipeDatabase;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> stringMaps = await db.query(
        'recipeStringTable');
    final List<Map<String, dynamic>> ingredientMaps = await db.query(
        'recipeIngredientsTable');
    final List<Map<String, dynamic>> directionsMaps = await db.query(
        'recipeDirectionsTable');


    return List.generate(stringMaps.length, (i) {
      return Recipe(
        title: stringMaps[i]['title'],
        picture: Image.file(File(stringMaps[i]['picture']), fit: BoxFit.fill),
        imagePath: stringMaps[i]['picture'],
        prepTime: stringMaps[i]['prepTime'],
        cookTime: stringMaps[i]['cookTime'],
        description: stringMaps[i]['description'],
        ingredientList: ingredientToList(ingredientMaps[i]),
        directionsList: directionsToList(directionsMaps[i]),
      );
    });
  }

  Future<void> saveRecipesToDatabase(List<Recipe> recipeList) async {
    final Database db = await recipeDatabase;

    await db.execute('DELETE FROM recipeStringTable');
    await db.execute('DELETE FROM recipeIngredientsTable');
    await db.execute('DELETE FROM recipeDirectionsTable');

    for (Recipe recipe in recipeList) {
      await db.insert(
        'recipeStringTable',
        recipe.nonListToMap(recipeList.indexOf(recipe)),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'recipeIngredientsTable',
        recipe.ingredientMap(recipeList.indexOf(recipe)),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'recipeDirectionsTable',
        recipe.directionsMap(recipeList.indexOf(recipe)),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }




  runApp(MyApp(saveFunction: saveRecipesToDatabase, loadFunction: loadRecipesFromDatabase));
}
//end of main








class MyApp extends StatelessWidget {
  
  MyApp({this.saveFunction, this.loadFunction});
  final Function(List<Recipe>) saveFunction;
  final Function loadFunction;
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CookbookModel>(
      create: (context) => CookbookModel(loadFunction: loadFunction),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Noto Serif', accentColor: mainColor, primaryColor: mainColor),
        home: HomeScreen(saveAllFunction: saveFunction),
      ),
    );
  }
}



List<String> testIngredients = ['5 cups of mayonnaise', '7 cups of walnuts', '8 bowls of flour', 'Dash of salt'];
List<String> testDirections = ['whisk everything in a big asshole pan', 'cut off your fingernail and put it in your face'];
Recipe testRecipe = Recipe(title: 'Tabbouli', picture: Image.asset('images/headshot.jpg'), imagePath: 'images/headshot.jpg',
  cookTime: 4, prepTime: 20, description: 'a really really really really really really really really really really really really really really really really really really really really really ', ingredientList: testIngredients,
directionsList: testDirections);

File testPicFile = File('/home/paris/Code/AndroidStudioProjects/mom_recipe_app/files/headshot.jpg');