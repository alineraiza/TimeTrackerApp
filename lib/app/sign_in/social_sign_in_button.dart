import 'package:flutter/material.dart';
import 'package:time_track_app/common_widgets/custom_raised_buttom.dart';

class SocialSignInButton extends CustomRaisedButtom{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color, 
    Color textColor,
    VoidCallback onPressed,
}) : assert(assetName != null),
     assert(text != null),
     super (
       child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Image.asset(assetName, height: 30.0),
                 Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: 15.0 ),
                 ),
                SizedBox(width: 30.0)
               ],
             ),
    color: color,
    onPressed: onPressed,
  );
}
