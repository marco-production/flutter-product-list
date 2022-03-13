import 'package:flutter/material.dart';
import 'package:login/Screens/home_screen.dart';
import 'package:login/providers/product_provider.dart';
import 'package:login/screens/product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => ProductProvider()),
    ],
    child: const MyApp());
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurpleAccent,
          elevation: 0
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple
        )
      ),

      initialRoute: '/home',

      routes: {
        '/home' : (BuildContext context) => HomeScreen(),
        '/product' : (BuildContext context) => ProductScreen(),
      },
    );
  }
}