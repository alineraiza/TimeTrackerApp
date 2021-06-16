import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_track_app/app/sign_in/validators.dart';
import 'package:time_track_app/common_widgets/form_submit_button.dart';
import 'package:time_track_app/common_widgets/show_alert_dialog.dart';
import 'package:time_track_app/services/auth.dart';


enum EmailSignInFormType{signIn, register}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators{
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
  bool _submitted = false;
  bool _isLoading = false;
  
  void _submit() async{
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if(_formType == EmailSignInFormType.signIn){
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(
        context,
        title: 'Sign in failed',
        content: e.toString(),
        defaultActionText: 'ok',
      );
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType(){
    setState(() {
      _submitted = false;
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
    
    bool submitEnabled = widget.emailValidator.isValid(_email) && 
    widget.passwordValidator.isValid(_password) && !_isLoading;

    return [
      _buildEmailTextField(),
       SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
       text: primaryText,
       onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrortext = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrortext ? widget.invalidPasswordErrorText: null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailControler,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText:  'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText: null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
          );
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
      
       void _updateState() {
         setState(() { 
          });
        }
}


