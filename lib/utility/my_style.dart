import 'package:flutter/material.dart';

//ใช้ภาพโลโก้ภาพเดียวกันในหน้า signและsignup จึงแยกมาสร้างคลาสใหม่
class MyStyle {
  BoxDecoration myBoxDecoration(var namePic) => BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/$namePic'), fit: BoxFit.cover),
      );

  Color darkColor = Colors.red.shade300;
  Color primaryColor = Colors.blue;

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(BuildContext context,String string) {
    return Center(
      child: Container(width: MediaQuery.of(context).size.width*0.5,
        child: Text(
          string,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget titleH3Dark(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          // fontWeight: FontWeight.w700,
          color: darkColor,
        ),
      );

  Widget titleH2Dark(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: darkColor,
        ),
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            color: Colors.red[400],
            fontWeight: FontWeight.bold),
      );
  Container showLogo() => Container(
        width: 150.0,
        child: Image.asset('images/delivery.png'),
      );

  MyStyle();
}
