import 'package:flutter/material.dart';
import 'package:time_track_app/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign in",
          style: TextStyle(
            color: Color(0xFFf2edd7),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card (
          child: EmailSignInForm(),
        ),
      ),
    );
  }
}