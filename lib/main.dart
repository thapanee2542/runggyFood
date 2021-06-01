import 'package:flutter/material.dart';
import 'package:runggyfood/screen/home.dart';
import 'package:runggyfood/utility/my_style.dart';

//เขียนแบบเต็ม
// void main() {
//   runApp(MyApp());
// }
//เขียนแบบย่อ
main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Rung Food',
      home: Home(),
    );
  }
}
