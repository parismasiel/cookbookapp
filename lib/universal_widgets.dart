import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';




class Recipe {

  String _title;
  Image _picture;
  String _imagePath;
  int _prepTime;
  int _cookTime;
  int _totalTime;
  String _description;
  List<String> _ingredientList;
  List<String> _directionsList;


  Recipe.blank() {
    _title = 'title';
    _picture = null;
    _imagePath = null;
    _prepTime = 0;
    _cookTime = 0;
    _totalTime = 0;
    _description = '';
    _ingredientList = [];
    _directionsList = [];
  }

  Recipe(
      {@required String title, @required Image picture, @required List<
          String> directionsList, @required String imagePath, @required List<String> ingredientList,
        @required int prepTime, @required int cookTime, @required String description})
      : _title = title,
        _picture = picture,
        _prepTime = prepTime,
        _imagePath = imagePath,
        _cookTime = cookTime,
        _description = description,
        _totalTime = cookTime + prepTime,
        _ingredientList = ingredientList,
        _directionsList = directionsList;

  static Image imageFromBase64String(String base64) {
    return Image.memory(
        base64Decode(base64),
        fit: BoxFit.fill
    );
  }

/*
  factory Recipe.fromJson(Map<String, dynamic> jsonData) {
    return Recipe(
        title: jsonData['title'],
        picture: imageFromBase64String(jsonData['picture']),
        imageBytes: jsonData['imageBytes'],
        prepTime: jsonData['prepTime'],
        cookTime: jsonData['cookTime'],
        description: jsonData['description'],
        ingredientList: jsonData['ingredientList'],
        directionsList: jsonData['directionsList']
    );
  }
*/
  String base64String(Uint8List data) {
    return base64Encode(data);
  }


  Map<String, dynamic> nonListToMap(int index) {
      return {
        'id': index,
        'title': this.title,
        'picture': this.imagePath,
        'prepTime': this.prepTime,
        'cookTime': this.cookTime,
        'totalTime': this.totalTime,
        'description': this.description,
      };
    }


  Map<String, dynamic> ingredientMap(int index) {
    return {
      'recipeId': index,
      'ingredientZero': _ingredientList.length > 0 ? _ingredientList[0] : null,
      'ingredientOne': _ingredientList.length > 1 ? _ingredientList[1] : null,
      'ingredientTwo': _ingredientList.length > 2 ? _ingredientList[2] : null,
      'ingredientThree': _ingredientList.length > 3 ? _ingredientList[3] : null,
      'ingredientFour': _ingredientList.length > 4 ? _ingredientList[4] : null,
      'ingredientFive': _ingredientList.length > 5 ? _ingredientList[5] : null,
      'ingredientSix': _ingredientList.length > 6 ? _ingredientList[6] : null,
      'ingredientSeven': _ingredientList.length > 7 ? _ingredientList[7] : null,
      'ingredientEight': _ingredientList.length > 8 ? _ingredientList[8] : null,
      'ingredientNine': _ingredientList.length > 9 ? _ingredientList[9] : null,
      'ingredientTen': _ingredientList.length > 10 ? _ingredientList[10] : null,
      'ingredientEleven': _ingredientList.length > 11 ? _ingredientList[11] : null,
      'ingredientTwelve': _ingredientList.length > 12 ? _ingredientList[12] : null,
      'ingredientThirteen': _ingredientList.length > 13 ? _ingredientList[13] : null,
      'ingredientFourteen': _ingredientList.length > 14 ? _ingredientList[14] : null
    };
  }

  Map<String, dynamic> directionsMap(int index) {
    return {
      'recipeId': index,
      'directionZero': _directionsList.length > 0 ? _directionsList[0] : null,
      'directionOne': _directionsList.length > 1 ? _directionsList[1] : null,
      'directionTwo': _directionsList.length > 2 ? _directionsList[2] : null,
      'directionThree': _directionsList.length > 3 ? _directionsList[3] : null,
      'directionFour': _directionsList.length > 4 ? _directionsList[4] : null,
      'directionFive': _directionsList.length > 5 ? _directionsList[5] : null,
      'directionSix': _directionsList.length > 6 ? _directionsList[6] : null,
      'directionSeven': _directionsList.length > 7 ? _directionsList[7] : null,
      'directionEight': _directionsList.length > 8 ? _directionsList[8] : null,
      'directionNine': _directionsList.length > 9 ? _directionsList[9] : null,
      'directionTen': _directionsList.length > 10 ? _directionsList[10] : null,
      'directionEleven': _directionsList.length > 11 ? _directionsList[11] : null,
      'directionTwelve': _directionsList.length > 12 ? _directionsList[12] : null,
      'directionThirteen': _directionsList.length > 13 ? _directionsList[13] : null,
      'directionFourteen': _directionsList.length > 14 ? _directionsList[14] : null
    };
  }



  List<String> get directionsList => _directionsList;
  String get imagePath => _imagePath;
  Image get picture => _picture;

  String get title => _title;

  int get totalTime => _totalTime;

  int get prepTime => _prepTime;

  set imagePath(String i) {
    _imagePath = i;
  }
  set title(String value) {
    _title = value;
  }

  set prepTime(int value) {
    _prepTime = value;
    updateTotalTime();
  }

  int get cookTime => _cookTime;

  set cookTime(int value) {
    _cookTime = value;
    updateTotalTime();
  }

  void updateTotalTime() {
    _totalTime = _cookTime + _prepTime;
  }



  String get description => _description;


  List<String> get ingredientList => _ingredientList;

  set picture(Image value) => _picture = value;


  set totalTime(int value) {
    _totalTime = value;
  }

  set description(String value) {
    _description = value;
  }

  set ingredientList(List<String> value) {
    _ingredientList = value;
  }

  set directionsList(List<String> value) {
    _directionsList = value;
  }
}





  class LetterTextForm extends StatefulWidget {

    //something related to multi-line must be done
    //set an index, and then onsubmit takes an index parameter. then the parent uses that index
    //index should be optional so we don't have to make a whole new one of these to work in the ingredient adder
    LetterTextForm(
        {this.maxLength, this.index, @required this.label, this.prefixIcon, @required this.onSubmit})
        : initialValue = '';

    final Widget prefixIcon;
    final int maxLength;
    final String label;
    final String initialValue;

    //if you provide index when instantiating, the onSubmit you provide must take two parameters.
    final Function onSubmit;
    final int index;


    LetterTextForm.withInit({@required this.label, this.maxLength, this.index,
      @required this.onSubmit, this.prefixIcon, @required this.initialValue});


    @override
    _LetterTextFormState createState() => _LetterTextFormState();

  }

    class _LetterTextFormState extends State<LetterTextForm> {


    @override
    void initState() {
    super.initState();
    }

    @override
    void dispose() {
    super.dispose();
    }


    @override
    Widget build(BuildContext context) {
    return TextFormField(
    maxLength: widget.maxLength ?? null,
    initialValue: widget.initialValue,
    onFieldSubmitted: widget.index != null ? (value) => widget.onSubmit(value, widget.index)
        : (value) => widget.onSubmit(value),
    decoration: InputDecoration(
    prefixIcon: widget.prefixIcon ?? null,
    labelText: widget.label,
    )
    );
    }
    }












class IngredientAdder extends StatefulWidget {

  IngredientAdder({@required this.sendList}) : initList = [];
  final Function(List<String>) sendList;
  final List<String> initList;
  IngredientAdder.withInit({@required this.sendList, @required this.initList});

  @override
  IngredientAdderState createState() => IngredientAdderState();
}

class IngredientAdderState extends State<IngredientAdder> {

  //list of fields and strings must be here, which will be initialized from provider data in the edit screen.
  //Then, when the save button is hit, the strings will be sent in to the recipe and thus to the model. Then the
  // change will be notified from the model and the list of strings here will change.

  List<LetterTextForm> _ingredientFields = [];
  List<String> _ingredientStrings = [];

  void setString(String string, int index) {
    setState(() {
      _ingredientStrings[index] = string;

    });
  }


  List<LetterTextForm> _generateFields(List<String> stringList) {
    List<LetterTextForm> list = [];
      for (String str in stringList) {
        LetterTextForm textForm = LetterTextForm.withInit(
            label: 'Ingredient', initialValue: str, onSubmit: setString,
            index: stringList.indexOf(str));
        list.add(textForm);
      }
      return list;
  }



  void addField() {
    setState(() {
      _ingredientFields.add(
          LetterTextForm(index: _ingredientFields.length, label: 'Ingredient',
              onSubmit: setString));
      _ingredientStrings.add('');
    });
  }

  void removeField() {
    setState(() {
      _ingredientFields.removeLast();
      _ingredientStrings.removeLast();
    });
  }

  List<Padding> paddedIngredientFields() {
    List<Padding> paddingList = [];
    if (_ingredientFields.isEmpty) {return paddingList;}
    else {
      for (LetterTextForm i in _ingredientFields) {
        Padding pad = Padding(padding: const EdgeInsets.all(8.0), child: i);
        paddingList.add(pad);
      }
      return paddingList;
    }
  }

  @override
  void initState() {
    _ingredientStrings = widget.initList;
    _ingredientFields = _generateFields(_ingredientStrings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mainColor,
        child: Column(
          children: [
            Container(
                color: mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ingredients'),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _ingredientFields.length < 15 ? addField : () {
                            Scaffold.of(context).showSnackBar(plusSnackBar);}),
                              IconButton(
                              icon: Icon(Icons.remove),
                          onPressed: _ingredientFields.isNotEmpty ? removeField : () {
                              Scaffold.of(context).showSnackBar(minusSnackBar);}
                            )
                            ],
                            )
                  ],
                )
            ),
            Column(
              children: paddedIngredientFields(),
            ),
            RaisedButton(
                child: Text('Save all'),
                onPressed: () => widget.sendList(_ingredientStrings)
            ),

          ],
        )
    );
  }
}










class DirectionsAdder extends StatefulWidget {

  final Function(List<String>) sendList;
  final List<String> initList;

  DirectionsAdder({@required this.sendList}) : initList = [];
  DirectionsAdder.withInit({@required this.sendList, @required this.initList});



  @override
  DirectionsAdderState createState() => DirectionsAdderState();
}

class DirectionsAdderState extends State<DirectionsAdder> {

  void setString(String string, int index) {
    setState(() {
      _directionsStrings[index] = string;
    });
  }

  //list of fields and strings must be here, which will be initialized from provider data in the edit screen.
  //Then, when the save button is hit, the strings will be sent in to the recipe and thus to the model. Then the
  // change will be notified from the model and the list of strings here will change.

  List<String> _directionsStrings = [];
  List<LetterTextForm> _directionsFields = [];


  List<LetterTextForm> _generateFields(List<String> stringList) {
    List<LetterTextForm> list = [];
    for (String str in _directionsStrings) {
      LetterTextForm textForm = LetterTextForm.withInit(label: 'Recipe Step', initialValue: str, onSubmit: setString,
      index: _directionsStrings.indexOf(str));
      list.add(textForm);
    }
    return list;
  }

  void addField() {
    setState(() {
      _directionsFields.add(
          LetterTextForm(index: _directionsFields.length, label: 'Recipe Step',
              onSubmit: setString));
      _directionsStrings.add('');
    });
  }

  void removeField() {
    setState(() {
      _directionsFields.removeLast();
      _directionsStrings.removeLast();
    });
  }

  List<Padding> paddedIngredientFields() {
    List<Padding> paddingList = List();
    for (LetterTextForm i in _directionsFields) {
      Padding pad = Padding(padding: const EdgeInsets.all(8.0), child: i);
      paddingList.add(pad);
    }
    return paddingList;
  }

  @override
  void initState() {
    _directionsStrings = widget.initList;
    _directionsFields = _generateFields(_directionsStrings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mainColor,
        child: Column(
          children: [
            Container(
                color: mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recipe Steps'),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _directionsFields.length < 15 ? addField : () {
                              Scaffold.of(context).showSnackBar(plusSnackBar);}
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: _directionsFields.isNotEmpty ? removeField : () {
                            Scaffold.of(context).showSnackBar(minusSnackBar);},
                        )
                      ],
                    )
                  ],
                )
            ),
            Column(
              children: paddedIngredientFields(),
            ),
            RaisedButton(
                child: Text('Save all'),
                onPressed: () => widget.sendList(_directionsStrings)
            ),

          ],
        )
    );
  }
}
















class DirectionsEditor extends StatefulWidget {

  DirectionsEditor({@required this.sendList});
  final Function(List<String>) sendList;

  @override
  DirectionsEditorState createState() => DirectionsEditorState();
}

class DirectionsEditorState extends State<DirectionsEditor> {

  void setString(String string, int index) {
    setState(() {
      _directionsStrings[index] = string;
    });
  }


  List<String> _directionsStrings = [];
  List<LetterTextForm> _directionsFields = [];



  void addField() {
    setState(() {
      _directionsFields.add(
          LetterTextForm(index: _directionsFields.length, label: 'Recipe Step',
              onSubmit: setString));
      _directionsStrings.add('');
    });
  }

  void removeField() {
    setState(() {
      _directionsFields.removeLast();
      _directionsStrings.removeLast();
    });
  }

  List<Padding> paddedIngredientFields() {
    List<Padding> paddingList = List();
    for (LetterTextForm i in _directionsFields) {
      Padding pad = Padding(padding: const EdgeInsets.all(8.0), child: i);
      paddingList.add(pad);
    }
    return paddingList;
  }
/*
  @override
  void initState() {
    addField();
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
        color: mainColor,
        child: Column(
          children: [
            Container(
                color: mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recipe Steps'),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: addField
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: removeField,
                        )
                      ],
                    )
                  ],
                )
            ),
            Column(
              children: paddedIngredientFields(),
            ),
            RaisedButton(
                child: Text('Save all'),
                onPressed: widget.sendList(_directionsStrings)
            ),

          ],
        )
    );
  }
}







class ImagePickerBox extends StatefulWidget {

final Function(Image, String) setFunction;
final String initImagePath;
ImagePickerBox({@required this.setFunction}) : initImagePath = null;
ImagePickerBox.withInit({@required this.setFunction, @required this.initImagePath});


  @override
  _ImagePickerBoxState createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {


  ImagePicker _imagePicker = ImagePicker();
  Future<PickedFile> pickedImageFuture;
  Image imageToShow;
  PickedFile pickedImageFile;
  File imageFile;
  Future<PickedFile> pickedFileFuture;
  String imagePath;
  bool showingPicked = false;

  pickImageFromGallery(ImageSource source) async {
    setState(() {
      pickedFileFuture = _imagePicker.getImage(source: source);

    });

  pickedImageFile = await pickedFileFuture;
  imageFile = File(pickedImageFile.path);
  imageToShow = Image.file(File(pickedImageFile.path), fit: BoxFit.fill);
  setThings(imageFile);
  updateImage(pickedImageFile);
  }

  updateImage(PickedFile pickedImageFile) {
    setState(() {
      imageToShow = Image.file(File(pickedImageFile.path), fit: BoxFit.fill);

    });
  }

  setThings(File imageFile) {
      imagePath = imageFile.path;
      widget.setFunction(imageToShow, imagePath);
  }

  @override
  void initState() {
    imageFile = widget.initImagePath != null ? File(widget.initImagePath) : null;
    imageToShow = widget.initImagePath != null ? Image.file(File(widget.initImagePath), fit: BoxFit.fill) : Image.asset('images/headshot.jpg');
    imagePath = widget.initImagePath ?? null;
    if (imageFile != null) {setThings(imageFile);}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: imageToShow,
          height: 300,
          width: 300,
        ),
        RaisedButton(
          onPressed: () => pickImageFromGallery(ImageSource.gallery),
          child: Text('Pick Image'),
        )
      ],
    );
  }
}




class RecipeCard extends StatelessWidget {

  RecipeCard(this.recipe, this.onTap, {@required this.index});
  final Recipe recipe;
  final Function onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Center(child: Text(recipe.title, style: bigFontStyle)),
          SizedBox(height: 30),
          Center(child: Text(recipe.description)),
          SizedBox(height: 50),
          Container(
              height: 200,
              width: 240,
              child: recipe.picture),
          SizedBox(height: 100),
          RaisedButton(
            child: Text('View Recipe'),
            onPressed: () {
              onTap(context, recipe, index);
            }
          )
          ],

          ),
    );
  }
}









class LetterControllerForm extends StatefulWidget {


  LetterControllerForm({@required this.controller, this.maxLength, this.index, @required this.label, this.prefixIcon, @required this.onSubmit});

  final Widget prefixIcon;
  final TextEditingController controller;
  final int maxLength;
  final String label;
  //if you provide index when instantiating, the onSubmit you provide must take two parameters.
  final Function onSubmit;
  final int index;



  @override
  _LetterControllerFormState createState() => _LetterControllerFormState();
}

class _LetterControllerFormState extends State<LetterControllerForm> {

/*
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength ?? null,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon ?? null,
          labelText: widget.label,
        )
    );
  }
}




