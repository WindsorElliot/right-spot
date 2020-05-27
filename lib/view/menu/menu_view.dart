import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:right_spot/view/map/map_view.dart';

class MenuView extends StatefulWidget {

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
      MapView(),
      Container(),
      Container()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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