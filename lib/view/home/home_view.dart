import 'package:flutter/material.dart';
import 'package:right_spot/controller/app_controller.dart';
import 'package:right_spot/controller/state/app_state.dart';
import 'package:right_spot/model/token.dart';
import 'package:right_spot/view/login_view.dart';
import 'package:right_spot/view/menu/menu_view.dart';
import 'package:right_spot/view/splashscreen/splashscreen_view.dart';

class HomeView extends StatelessWidget {

  final AppController _appController = AppController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState<Token>>(
      stream: this._appController.stream,
      initialData: AppState.loading(''),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.data.status) {
          case AppStatus.APP_NOT_LOGGED:
            return LoginView(appController: this._appController);
          case AppStatus.APP_LOGED:
            return MenuView(appController: this._appController);
          case AppStatus.APP_LOADING:
            return SplashScreenView();
          default:
            return LoginView(appController: this._appController);
        }
      }
    );
  }

}