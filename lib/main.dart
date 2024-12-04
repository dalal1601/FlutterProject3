import 'package:flutter/material.dart';
import 'package:flutter_application_03/screens/home.page.dart';
import 'package:flutter_application_03/screens/login.page.dart';
import 'package:flutter_application_03/screens/register.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme : ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true
      ),
      title: 'dalal s app',
      //home: HomePage(),  no need cuz we have initial route
      initialRoute: '/login',
      routes: {  //map (cle val)
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        '/home':(context) => HomePage(),

      }, 
    );
  }
}
