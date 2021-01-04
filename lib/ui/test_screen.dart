import 'package:flutter/material.dart';


class TestScreen extends StatelessWidget {
  TestScreen(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(index.toString()))
      )
    );
  }
}
