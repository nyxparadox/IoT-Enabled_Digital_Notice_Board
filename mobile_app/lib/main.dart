import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/authScreens/signInScreen.dart';
import 'package:mobile_app/Services/serviceLocater.dart';
import 'package:mobile_app/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setUpServiceLocater();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const MyHomePage(title: 'NoticeDesk'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Signinscreen(),
    );
    
  }
}
