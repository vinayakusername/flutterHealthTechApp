import 'package:flutter/material.dart';
import 'package:health_tech_app1/Views/widget_searchBarPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.pink
      ),
      //home: LoginRegisterPage(),

      home: SearchBarPage(),
    );
      
     
  }
}


