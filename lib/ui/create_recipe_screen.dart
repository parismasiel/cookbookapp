import 'package:flutter/material.dart';
import 'package:mom_recipe_app/constants.dart';
import 'package:mom_recipe_app/universal_widgets.dart';
import 'package:mom_recipe_app/models/cookbook_model.dart';
import 'package:provider/provider.dart';

//maybe on back button delete the recipe

class CreateWithControllers extends StatefulWidget {


  @override
  _CreateWithControllersState createState() => _CreateWithControllersState();
}

class _CreateWithControllersState extends State<CreateWithControllers> {



  Recipe thisRecipe = Recipe.blank();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController prepTimeController = TextEditingController();
  TextEditingController cookTimeController = TextEditingController();


  //Screen's functions:




  void sendTitle() {
      thisRecipe.title = titleController.text;
  }

  void sendPicture(Image image, String imagePath) {
    thisRecipe.picture = image;
    thisRecipe.imagePath = imagePath;
  }

  void sendDescription() {
    thisRecipe.description = descriptionController.text;
  }

  void sendDirections(List<String> list) {
    thisRecipe.directionsList = list;
  }

  void sendIngredients(List<String> list) {
    thisRecipe.ingredientList = list;
  }

  void sendPrepTime() {
    if (int.parse(prepTimeController.text) != null) {
      thisRecipe.prepTime = int.parse(prepTimeController.text);
    }
    else {print('sendPrepTime failed to parse the string to an int.');
    return; }
  }

  void sendCookTime() {
    if (int.parse(cookTimeController.text) != null) {
      thisRecipe.cookTime = int.parse(cookTimeController.text);
    }
    else {print('sendCookTime failed to parse the string to an int.');
    return; }
  }

  void saveEverything() {
    setState(() {
      sendTitle();
      sendDescription();
      sendCookTime();
      sendPrepTime();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    prepTimeController.dispose();
    cookTimeController.dispose();
    super.dispose();
  }
  //full screen build:

  @override
  Widget build(BuildContext context) {

    var watcher = context.watch<CookbookModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add a Recipe'),
        ),
        body: Container(
            color: greyColor,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LetterControllerForm(
                        controller: titleController,
                        onSubmit: sendTitle, label: 'Title'
                    ),
                  )),
                ),
                ImagePickerBox(setFunction: sendPicture),
                //time row
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Card(child: LetterControllerForm(controller: prepTimeController,
                          onSubmit: sendPrepTime, label: 'Prep Time (min)'))),
                      Expanded(child: Card(child: LetterControllerForm(
                          controller: cookTimeController, onSubmit: sendCookTime, label: 'Cook Time (min)')))
                    ],
                  ),
                ),
                LetterControllerForm(controller: descriptionController, label: 'Description', onSubmit: sendDescription, maxLength: 160),
                IngredientAdder(sendList: sendIngredients),
                DirectionsAdder(sendList: sendDirections),
                RaisedButton(
                  onPressed: () {
                    saveEverything();
                    watcher.addRecipe(thisRecipe);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('Save Recipe'),
                )
              ],
            )
        )
    );
  }
}
















