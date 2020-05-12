import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreenView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blueAccent,
      child: Center(
        child: Text('Right Spot',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}