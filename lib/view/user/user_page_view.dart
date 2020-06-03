import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:right_spot/controller/bloc/user_bloc.dart';
import 'package:right_spot/controller/event/user_event.dart';
import 'package:right_spot/controller/state/api_response.dart';
import 'package:right_spot/model/user.dart';
import 'package:right_spot/view/helper/widget_helper.dart';
import 'package:right_spot/view/user/change_password_view.dart';
import 'package:right_spot/view/user/profil_image_view.dart';

class UserPageView extends StatefulWidget {
  final UserBloc userBloc;

  UserPageView({ @required this.userBloc });

  @override
  _UserPageViewState createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {

  TextEditingController _usernameController;
  TextEditingController _emailController;
  bool _changePassewordIsSelected;

  @override
  void initState() {
    widget.userBloc.add(GetCurrentUserEvent());
    _usernameController = TextEditingController();
    _emailController = TextEditingController.fromValue(TextEditingValue(text: widget.userBloc.state.data?.email ?? ''));
    _changePassewordIsSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: BlocConsumer(
        bloc: widget.userBloc,
        listener: (BuildContext context, ApiResponse<User> state) {
          if (state.status == Status.COMPLETED) {
            this.setState(() {
              _usernameController.text = state.data.username;
            });
          }
        },
        builder: (BuildContext context, ApiResponse<User> state) {
          return SafeArea(
            bottom: false,
            right: false,
            left: false,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(255, 255, 255, 1.0), Color.fromRGBO(44, 72, 171, 1.0)],
                  tileMode: TileMode.clamp,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: this._handleTapBackground,
                child: Stack(
                  children: [
                    Positioned(top: 0, left: 20, height: 50,
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(Icons.close),
                            Text('fermer')
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ),
                    Positioned(top: 0, left: 0, right: 0,
                      child: Container(
                        child: Center(
                          child: ProfileImageView(imageurl: state?.data?.profilImageUrl ?? null),
                        ),
                      ),
                    ),
                    Positioned(top: 220, right: 0, left: 0, bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              WidgetHelper.classiqueTextfield(context: context, controller: this._usernameController, helperMessage: "username", iconData: Icons.person),
                              SizedBox(height: 40),
                              WidgetHelper.classiqueTextfield(context: context, controller: this._emailController, helperMessage: "email", iconData: Icons.email),
                              SizedBox(height: 40),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: (this._changePassewordIsSelected == false) ? Colors.white : Colors.blueAccent
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular( (_changePassewordIsSelected == false) ? 90 : 45)),
                                  color: Colors.white24
                                ),
                                height: (this._changePassewordIsSelected == false) ? 60 : 300,
                                child: InkWell(
                                  onTap: () => {
                                    this.setState(() { _changePassewordIsSelected = true; })
                                  },
                                  child: (this._changePassewordIsSelected == false)
                                    ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.vpn_key, color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('changer votre mot de passe',
                                            style: GoogleFonts.portLligatSans(
                                              textStyle: Theme.of(context).textTheme.headline4,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    : ChangePasswordView(handleTapCancelButton: () {
                                      this.setState(() { _changePassewordIsSelected = false; });
                                    })
                                ),
                              ),
                              SizedBox(height: 40),
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                height: 60,
                                child: RaisedButton(
                                  onPressed: () {

                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  color: Colors.greenAccent,
                                  child: Text('Enregistrer',
                                    style: GoogleFonts.portLligatSans(
                                      textStyle: Theme.of(context).textTheme.headline4,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              )
            )
          );
        },
      ),
    );
  }

  void _handleTapBackground() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (false == currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (true == this._changePassewordIsSelected) {
      this.setState(() {
        _changePassewordIsSelected = false;
      });
    }
  }

  OutlineInputBorder get textFieldBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(
      color: Colors.white60,
    )
  );

  OutlineInputBorder get textFieldFocusedBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(
      width: 1,
      color: Colors.blueAccent
    )
  );
}