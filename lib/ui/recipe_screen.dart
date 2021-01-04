import 'edit_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:mom_recipe_app/universal_widgets.dart';
import 'package:mom_recipe_app/constants.dart';


class RecipeScreen extends StatefulWidget {

  RecipeScreen({@required this.recipe, @required this.index});
  final Recipe recipe;
  final int index;

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {


  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: 'Summary'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.food_bank),
        label: 'Ingredients'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.arrow_circle_up),
        label: 'Directions'
      )
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        SummaryPage(recipe: widget.recipe),
        IngredientsPage(recipe: widget.recipe),
        DirectionsPage(recipe: widget.recipe)
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }


  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void showSnackbar(BuildContext context) {
    var snackBar = SnackBar(
      content: Text('Functionality not actually available, sorry.'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);

  }
//build whole recipe screen:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.recipe.title} Recipe'),
        leading: BackButton(),
        actions: [
          IconButton(icon: Icon(Icons.edit), onPressed: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditRecipeScreen(suppliedRecipe: widget.recipe, index: widget.index),
      ));
    },
          )]
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
        onTap: (index) => bottomTapped(index),
      )
    );
  }
}



class SummaryPage extends StatelessWidget {

  SummaryPage({@required this.recipe});
  final Recipe recipe;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopSizedBox(),
          Center(child: Text(recipe.title, style: bigFontStyle)),
          Container(height: 245, child: recipe.picture),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Icon(Icons.hourglass_bottom),
                      Text('Preparation Time:', style: mediumFontStyle),
                      Text('${recipe.prepTime.toString()} min', style: mediumFontStyle)
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Icon(Icons.hourglass_bottom),
                      Text('Cook Time:', style: mediumFontStyle),
                      Text('${recipe.cookTime.toString()} min', style: mediumFontStyle)
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Icon(Icons.hourglass_bottom),
                        Text('Total Time:', style: mediumFontStyle),
                      Text('${recipe.totalTime.toString()} min', style: mediumFontStyle)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      Text('Description:', style: bigFontStyle.copyWith(fontSize: 21), textAlign: TextAlign.start),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(recipe.description, style: mediumFontStyle, softWrap: true)
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}








class IngredientsPage extends StatelessWidget {

  IngredientsPage({@required this.recipe});
  final Recipe recipe;

  Widget buildLine(BuildContext context, int index) {
    String str = recipe.ingredientList[index];
    if (str == null) {
      return Visibility(visible: 0 == 1, child: Container(color: Colors.blue));
    }
    else {
      List list = str.split(' ');
    List furtherList = str.split(RegExp(r'[0-9] '));

    String number = list[0];
    if (str.startsWith(RegExp(r'[0-9]'))) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Text(number,
                style: mediumBoldStyle.copyWith(color: Colors.amber[300])),
            SizedBox(width: 4),
            Text(furtherList[1], style: mediumBoldStyle)
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
            children: [
              Text(str, style: mediumBoldStyle)
            ]
        ),
      );
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopSizedBox(),
        Text('Ingredients', style: bigFontStyle),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemBuilder: buildLine,
            itemCount: recipe.ingredientList.length,
          ),
        ),
      ],
    );
  }
}



class DirectionsPage extends StatelessWidget {

  DirectionsPage({@required this.recipe});
  final Recipe recipe;
  Widget buildDirectionList(BuildContext context, int index) {
    String str = recipe.directionsList[index];
    if (str == null) {
      return Visibility(visible: 0 == 1, child: Container());
    }
    else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 20,
                  width: 20,
                  child: Row(
                    children: [
                      SizedBox(width: 6),
                      Text('${index + 1}'),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[500],
                    shape: BoxShape.circle,
                  )
              ),
            ),
            Expanded(child: Text(str, style: mediumFontStyle, softWrap: true))
          ],
        ),
      );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopSizedBox(),
        Center(child: Text('Directions', style: bigFontStyle)),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: recipe.directionsList.length,
            itemBuilder: buildDirectionList,
          ),
        ),
      ],
    );
  }
}







class TopSizedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 10);
  }
}









