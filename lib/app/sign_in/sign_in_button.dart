import 'package:flutter/material.dart';
import 'package:time_track_app/common_widgets/custom_raised_buttom.dart';

class SignInButton extends CustomRaisedButtom{
  SignInButton({
    @required String text,
    Color color, 
    Color textColor,
    VoidCallback onPressed,
  }) : assert(text != null),
       super (
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15.0),
        ),
        color: color,
        onPressed: onPressed,
       );
}