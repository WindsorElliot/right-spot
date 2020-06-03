import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:right_spot/view/helper/widget_helper.dart';

class ChangePasswordView extends StatefulWidget {
  final Function handleTapCancelButton;

  ChangePasswordView({ @required this.handleTapCancelButton });

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final streamController = StreamController();

  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _copyNewPasswordController;

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _copyNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 300), () {
      this.streamController.add("finish");
    });
    return StreamBuilder(
      stream: this.streamController.stream,
      builder: (BuildContext context, state) {
        if (false == state.hasData) {
          return Container();
        }
        else {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                WidgetHelper.classiqueTextfield(context: context, controller: this._oldPasswordController, helperMessage: "ancien mot de passe", iconData: Icons.vpn_key, isSecure: true),
                WidgetHelper.classiqueTextfield(context: context, controller: this._newPasswordController, helperMessage: "nouveau mot de passe", iconData: Icons.vpn_key, isSecure: true),
                WidgetHelper.classiqueTextfield(context: context, controller: this._copyNewPasswordController, helperMessage: "retaper le nouveau mot de passe", iconData: Icons.vpn_key, isSecure: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 65)/2,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        color: Colors.redAccent,
                        onPressed: widget.handleTapCancelButton,
                        child: Text('annuler',
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 65)/2,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        color: Colors.greenAccent,
                        onPressed: () {

                        },
                        child: Text('valider',
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
                )
              ],
            ),
          );
        }
      }
    );
  }

  OutlineInputBorder get textFieldBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(
      color: Colors.white60,
    )
  );

}