import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/Home_screen.dart';
import 'package:todoapp/shared/bloc_observer.dart';
void main() {
  BlocOverrides.runZoned(
        () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:   HomeScreen(),
    );


  }
}
