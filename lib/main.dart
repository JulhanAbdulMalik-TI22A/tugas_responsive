import 'package:flutter/material.dart';
import 'package:ppm_uts_julhan/pages/home_student.dart';
import 'package:ppm_uts_julhan/pages/home_profile.dart';
import 'package:ppm_uts_julhan/pages/onboarding.dart';
import './pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),

      //
      home: const OnboardingScreen(),
      // home: HomePage(),
      routes: {
        '/home-page': (context) => HomePage(),
        HomeStudent.routeName: (context) => HomeStudent(),
        HomeProfile.routeName: (context) => HomeProfile(),
      },
    );
  }
}
