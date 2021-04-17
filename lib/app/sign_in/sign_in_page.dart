import 'package:flutter/material.dart';
import 'package:time_track_app/app/sign_in/e-mail_sign_in_page.dart';
import 'package:time_track_app/app/sign_in/sign_in_button.dart';
import 'package:time_track_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_track_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  
  Future<void> _signInAnonymously() async {
    try{
    await auth.signInAnonymously();
    } catch(e){
    print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try{
    await auth.signInWithGoogle();
    } catch(e){
    print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try{
    await auth.signInWithFacebook();
    } catch(e){
    print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog:true,
        builder: (context) => EmailSignInPage(auth: auth,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Time Tracker",
          style: TextStyle(
            color: Color(0xFFf2edd7),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 40.0),
            SocialSignInButton(
              assetName: 'images/google.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Color(0xfff2edd7),
              onPressed: _signInWithGoogle,
            ),
            SizedBox(height: 10.0),
            SocialSignInButton(
              assetName: 'images/facebook.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xff334d92),
              onPressed: _signInWithFacebook,
            ),
            SizedBox(height: 10.0),
            SignInButton(
              text: 'Sign in with E-mail',
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: () => _signInWithEmail(context),
            ),
            SizedBox(height: 25.0),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.0),
            SignInButton(
              text: 'Go anonymous',
              textColor: Colors.black,
              color: Color(0xffe48257),
              onPressed: _signInAnonymously,
            ),
          ]),
    );
  }
}