import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/firebase_options.dart';
import 'package:firebase_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primaryColor: const Color(0xFF484848), // Cor principal
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF484848),
          secondary: const Color(0xFF604848),
          surface: const Color(0xFFD8D8D8),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF484848),
          iconTheme: IconThemeData(color: Color(0xFFC0C0A8)),
          titleTextStyle: TextStyle(
            color: Color(0xFFC0C0A8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF484848)),
          bodyMedium: TextStyle(color: Color(0xFF604848)),
          titleMedium: TextStyle(color: Color(0xFF484848)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFFF0F0F0),
            backgroundColor: const Color(0xFF604848),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFD8D8D8),
          labelStyle: TextStyle(color: Color(0xFF484848)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF604848)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD8D8D8)),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
