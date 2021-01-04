import 'package:flutter/material.dart';


const Color mainColor = Color(0xffB23A48);
const Color greyColor = Color(0xffCEB5A7);
final RegExp regEx = RegExp(r'[a-zA-z]');
final RegExp numRegEx = RegExp(r'[0-9]');

const TextStyle bigFontStyle = TextStyle(fontSize: 24, fontFamily: 'Noto Serif');
const TextStyle mediumFontStyle = TextStyle(fontSize: 15, fontFamily: 'Noto Serif');
const TextStyle mediumBoldStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Noto Serif');

const SnackBar plusSnackBar = SnackBar(content: Text('You\'re already maxed out here.'));
const SnackBar minusSnackBar = SnackBar(content: Text('You can\'t take away what doesn\'t exist.'));
