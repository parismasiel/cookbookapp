import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mom_recipe_app/models/cookbook_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mom_recipe_app/universal_widgets.dart';
import 'recipe_screen.dart';



class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  void toRecipe(BuildContext context, Recipe recipe, int index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => RecipeScreen(recipe: recipe, index: index )
    ));
  }

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<CookbookModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Dawn\'s Recipe App'),
        ),
        body: Swiper(
            viewportFraction: 0.8,
            itemCount: watcher.numberOfRecipes,
            pagination: SwiperPagination(),
            control: SwiperControl(),
            itemBuilder: (context, index) {
              return RecipeCard(watcher.getRecipeAt(index), toRecipe, index: index);
            }
        )
    );
  }
}
