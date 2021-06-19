import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_track_app/app/sign_in/e-mail_sign_in_page.dart';
import 'package:time_track_app/app/sign_in/sign_in_button.dart';
import 'package:time_track_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_track_app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_track_app/services/auth.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  void _showSignInError(BuildContext context, Exception exception){
    if (exception is FirebaseAuthException && exception.code == 'ERROR_ABORTED_BY_USER')
    return;
    showExceptionAlertDialog(context, title: 'Sign in Failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try{
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch(e){
      _showSignInError(context, e);
    } finally {
        setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try{
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch(e){
      _showSignInError(context, e);
   } finally {
      setState(() => _isLoading = false);
   }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try{
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on Exception catch(e){
      _showSignInError(context, e);
   } finally {
      setState(() => _isLoading = false);
   }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog:true,
        builder: (context) => EmailSignInPage()
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
            SizedBox(
              height: 50.0, 
              child: _buildHeader()
            ),
            SizedBox(height: 40.0),
            
            SocialSignInButton(
              assetName: 'images/google.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Color(0xfff2edd7),
              onPressed: _isLoading ? null : () => _signInWithGoogle(context),
            ),

            SizedBox(height: 10.0),
            SocialSignInButton(
              assetName: 'images/facebook.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xff334d92),
              onPressed: _isLoading ? null : () => _signInWithFacebook(context),
            ),

            SizedBox(height: 10.0),
            SignInButton(
              text: 'Sign in with E-mail',
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: _isLoading ? null : () => _signInWithEmail(context),
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
              onPressed: _isLoading ? null : () => _signInAnonymously(context),
            ),
          ],
      ),
    );
  }
  Widget _buildHeader(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}