import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_track_app/app/landing_page.dart';
import 'package:time_track_app/services/auth.dart';

Future<void> main() async{
  try {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  } catch(e){
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primaryColor: Color(0xFF3a6351),
        ),
        home: LandingPage(),
      ),
    );
  }
}
// class Child {
// }
