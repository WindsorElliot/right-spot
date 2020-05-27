import 'package:flutter/material.dart';
import 'package:right_spot/view/kfdrawer/kfdrawer.dart';
import 'package:right_spot/view/list/list_view.dart';
import 'package:right_spot/view/map/map_view.dart';
import 'package:right_spot/view/pool/pool_view.dart';

class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  KFDrawerController _kfDrawerController;

  @override
  void initState() {
    _kfDrawerController = KFDrawerController(
      initialPage: MapView(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Carte',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.map),
          page: MapView(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('List',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.list),
          page: ListSpotView()
        ),
        KFDrawerItem.initWithPage(
          text: Text('Pool',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.directions_car),
          page: PoolView(),
        )
      ]
    ); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: this._kfDrawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Icon(Icons.settings)
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'Réglages',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            print("pressed !!!");
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(255, 255, 255, 1.0), Color.fromRGBO(44, 72, 171, 1.0)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }

}