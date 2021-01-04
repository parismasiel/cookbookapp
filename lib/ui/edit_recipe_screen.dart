import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mom_recipe_app/models/cookbook_model.dart';
import 'package:mom_recipe_app/ui/home_screen.dart';
import 'package:mom_recipe_app/universal_widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:mom_recipe_app/constants.dart';


class EditRecipeScreen extends StatefulWidget {

  //back button
  //max line null

  EditRecipeScreen({@required this.index, @required this.suppliedRecipe}) : titleController = TextEditingController(text:suppliedRecipe.title),
  descriptionController = TextEditingController(text:suppliedRecipe.description),
        prepTimeController = TextEditingController(text:suppliedRecipe.prepTime.toString()),
      cookTimeController = TextEditingController(text: suppliedRecipe.cookTime.toString());
  final int index;
  final Recipe suppliedRecipe;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController prepTimeController;
  final TextEditingController cookTimeController;


  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {

  Recipe thisRecipe = Recipe.blank();
  int count = 0;


  void sendTitle() {
    thisRecipe.title = widget.titleController.text;
  }

  void sendDescription() {
    thisRecipe.description = widget.descriptionController.text;
  }

  void sendDirections(List<String> list) {
    thisRecipe.directionsList = list;
  }

  void sendPicture(Image image, String imagePath) {
    thisRecipe.picture = image;
    thisRecipe.imagePath = imagePath;
  }

  void sendIngredients(List<String> list) {
    thisRecipe.ingredientList = list;
  }

  void sendPrepTime() {
    if (int.parse(widget.prepTimeController.text) != null) {
      thisRecipe.prepTime = int.parse(widget.prepTimeController.text);
    }
    else {print('sendPrepTime failed to parse the string to an int.');
    return; }
  }

  void sendCookTime() {
    if (int.parse(widget.cookTimeController.text) != null) {
      thisRecipe.cookTime = int.parse(widget.cookTimeController.text);
    }
    else {print('sendCookTime failed to parse the string to an int.');
    return; }
  }

  void saveEverything() {
    setState(() {
      sendDescription();
      sendTitle();
      sendPrepTime();
      sendCookTime();
    });
    }

  @override
  void dispose() {
    widget.titleController.dispose();
    widget.descriptionController.dispose();
    widget.cookTimeController.dispose();
    widget.prepTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<CookbookModel>();

    return Scaffold(
        appBar: AppBar(
            title: Text('Edit Recipe'),
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
                      controller: widget.titleController,
                      label: 'Title',
                      onSubmit: sendTitle,
                    ),
                  )),
                ),
                ImagePickerBox.withInit(setFunction: sendPicture, initImagePath: widget.suppliedRecipe.imagePath),
                //time row
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Card(child: LetterControllerForm(
                          controller: widget.prepTimeController,
                          label: 'Prep Time (min)', onSubmit: sendPrepTime))),
                      Expanded(child: Card(child: LetterControllerForm(
                          controller: widget.cookTimeController,
                          label: 'Cook Time (min)', onSubmit: sendCookTime))),
                    ],
                  ),
                ),
                LetterControllerForm(onSubmit: sendDescription, label: 'Description',
                controller: widget.descriptionController, maxLength: 160),
                IngredientAdder.withInit(initList: watcher.getRecipeIngredients(widget.index),
                sendList: sendIngredients),
                DirectionsAdder.withInit(initList: watcher.getRecipeDirections(widget.index),
                sendList: sendDirections),
                RaisedButton(
                  onPressed: () {
                      saveEverything();
                      watcher.setRecipeAt(thisRecipe, widget.index);
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });                    },
                  child: Text('Save Recipe'),
                ),
                RaisedButton(
                  child: Text('Delete Recipe'),
                  onPressed: () {
                    watcher.deleteRecipeAt(widget.index);
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  }
                )
              ],
            )
        )
    );
  }
}
