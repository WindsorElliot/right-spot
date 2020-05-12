import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:right_spot/controller/app_controller.dart';

class MenuView extends StatefulWidget {
  final AppController appController;

  MenuView({ @required this.appController });

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

  int _selctedView;
  List<Widget> _views;

  @override
  void initState() {
    _selctedView = 0;
    _views = [
      Container(),
      Container(),
      Container()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._views.elementAt(this._selctedView),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.map, title: 'Carte'),
          TabData(iconData: Icons.list, title: 'Liste'),
          TabData(iconData: Icons.directions_car, title: 'Pool')
        ], 
        onTabChangedListener: (int index) {
          this.setState(() {
            _selctedView = index;
          });
        }
      )
    );
  }
}