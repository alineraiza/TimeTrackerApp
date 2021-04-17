import 'package:flutter/material.dart';
import 'package:time_track_app/common_widgets/custom_raised_buttom.dart';

class FormSubmitButton extends CustomRaisedButtom{
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    height: 44.0,
    color: Color(0xff3a6351),
    borderRadius: 4.0,
    onPressed: onPressed
  );
}