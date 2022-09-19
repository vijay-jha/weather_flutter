import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather/registration.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/screens/user_location_screen.dart';
import 'package:weather/screens/weather_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'आपका मौसम',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return HomeScreen();
          }
          // return Registration();
          return HomeScreen();
        },
      ),
      // home: const Registration(),
      routes: {
        '/weather_detail_screen': (context) => WeatherDetailScreen(),
        '/user_location_screen': (context) => UserLocationScreen(),
      },
    );
  }
}
