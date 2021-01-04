import 'package:flutter/material.dart';
import 'package:mom_recipe_app/constants.dart';
import 'package:mom_recipe_app/ui/create_recipe_screen.dart';
import 'list_screen.dart';
import 'package:provider/provider.dart';
import 'package:mom_recipe_app/models/cookbook_model.dart';


class HomeScreen extends StatelessWidget {

  HomeScreen({this.saveAllFunction});
  final Function saveAllFunction;

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<CookbookModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dawn\'s Recipe App'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100),
              Center(child: Text('Welcome, Mother!', style: bigFontStyle)),
              SizedBox(height: 30),
              CircleAvatar(backgroundImage: AssetImage('images/headshot.jpg')),
              SizedBox(height: 100),
              InkWell(
                  splashColor: Colors.blue[300],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CreateWithControllers()
                    ));
                  },
                  child: Card(
                  child: Container(
                  height: 40,
                  width: 210,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text('Create a New Recipe!')
                    ]
                  )
              )
              )),
              InkWell(
                  splashColor: Colors.blue[300],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ListScreen()
                    ));
                  },
                  child: Card(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.book),
                        Text('My Cookbook'),
                        SizedBox(width: 19),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              Text(watcher.numberOfRecipes.toString(), style: TextStyle(fontSize: 20)),
                              Text('Recipes')
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 60,
                    width: 210,
                  )
              )),
              RaisedButton(
                child: Text('Save All'),
                onPressed: () => saveAllFunction(watcher.recipeList),
              )
            ],
          )
        )
      )
    );
  }
}
