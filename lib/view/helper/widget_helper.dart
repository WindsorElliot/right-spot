import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetHelper {

  static Widget classiqueTextfield({@required BuildContext context, TextEditingController controller, String helperMessage, IconData iconData, bool isSecure = false}) {
    return TextField(
      style: GoogleFonts.portLligatSans(
        textStyle: Theme.of(context).textTheme.headline4,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      controller: controller,
      obscureText: isSecure,
      decoration: InputDecoration(
        focusedBorder: textFieldFocusedBorder,
        enabledBorder: textFieldBorder,
        prefixIcon: Icon(iconData, color: Colors.white),
        hintStyle: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        filled: true,
        fillColor: Colors.white24,
        hintText: helperMessage,
        labelText: helperMessage,
        labelStyle: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
  }

  static OutlineInputBorder get textFieldBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(
      color: Colors.white60,
    )
  );

  static OutlineInputBorder get textFieldFocusedBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(
      width: 1,
      color: Colors.blueAccent
    )
  );
}