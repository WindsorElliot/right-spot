import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:right_spot/controller/bloc/app_bloc.dart';
import 'package:right_spot/controller/state/app_state.dart';
import 'package:right_spot/model/user.dart';
import 'package:right_spot/view/login_view.dart';
import 'package:right_spot/view/main_view.dart';
import 'package:right_spot/view/splashscreen/splashscreen_view.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  AppBloc _appBloc;

  @override
  void initState() {
    _appBloc = AppBloc();
    super.initState();
  }

  @override
  void dispose() {
    _appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => this._appBloc,
      child: BlocBuilder(
        bloc: this._appBloc,
        builder: (BuildContext context, AppState<User> state) {
          switch(state.status) {
            case AppStatus.APP_LOADING:
              return SplashScreenView();
              break;
            case AppStatus.APP_NOT_LOGGED:
              return LoginView();
              break;
            case AppStatus.APP_LOGED:
              return MainView();
              break;
            case AppStatus.APP_ERROR:
              print(state.message);
              return LoginView();
              break;
            default:
              return SplashScreenView();
          }
        },
      ),
    );
  }
}