import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:right_spot/controller/bloc/user_bloc.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/user.dart';
import 'package:right_spot/view/list/list_view.dart';
import 'package:right_spot/view/map/map_view.dart';
import 'package:right_spot/view/pool/pool_view.dart';
import 'package:right_spot/view/user/user_page_view.dart';

class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  UserBloc _userBloc;
  KFDrawerController _kfDrawerController;

  @override
  void initState() {
    _userBloc = UserBloc();
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
  void dispose() {
    _userBloc.close();
    _kfDrawerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avaibleWidth = MediaQuery.of(context).size.width * (2/3);
    return Scaffold(
      body: BlocBuilder(
        bloc: this._userBloc,
        builder: (BuildContext context, ApiResponse<User> state) {
          return KFDrawer(
            controller: this._kfDrawerController,
            header: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: avaibleWidth/2 - 90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: (state.status == Status.COMPLETED)
                      ? [
                        InkWell(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 90,
                            child: CircleAvatar(
                              backgroundImage: (state.data.profilImageUrl != null)
                                ? NetworkImage(state.data.profilImageUrl)
                                : Icon(Icons.person),
                              backgroundColor: Colors.white,
                              radius: 85,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => UserPageView(userBloc: this._userBloc)
                              )
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Text(state.data.username,
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                      ]
                      : [
                        
                      ],
                ),
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
          );
        }
      )
    );
  }

}