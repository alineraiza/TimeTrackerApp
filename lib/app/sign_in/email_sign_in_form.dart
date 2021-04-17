import 'package:flutter/material.dart';
import 'package:time_track_app/common_widgets/form_submit_button.dart';
import 'package:time_track_app/services/auth.dart';

enum EmailSignInFormType{signIn, register}

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInformState createState() => _EmailSignInformState();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _EmailSignInformState extends State<EmailSignInForm> {  
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String get _email => _emailControler.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  
  void _submit() async{
    try {
      if(_formType == EmailSignInFormType.signIn){
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType(){
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ?
        EmailSignInFormType.register: EmailSignInFormType.signIn;
    });
    _emailControler.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    final primaryText = _formType == EmailSignInFormType.signIn ?
          'Sign in': 'Create an acconunt';
    final secondaryText = _formType == EmailSignInFormType.signIn ?
          'Need an account? Register': 'Have an account? Sign in';
    return [
      TextField(
        controller: _emailControler,
        decoration: InputDecoration(
          labelText: 'E-mail',
          hintText:  'test@test.com'
        ),
      ),
       SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password'
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
       text: primaryText,
       onPressed: _submit,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _toggleFormType,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.min ,
          children: _buildChildren (),
        ),
      ),
    );
  }
}

