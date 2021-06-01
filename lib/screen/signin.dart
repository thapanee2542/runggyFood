import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:runggyfood/model/user_model.dart';
import 'package:runggyfood/screen/main_shop.dart';
import 'package:runggyfood/screen/main_user.dart';
import 'package:runggyfood/utility/my_style.dart';
import 'package:runggyfood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Field
  var user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
        title: Text('Sign In'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //แสดงโลโก้
                MyStyle().showLogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('LALALU'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyStyle().darkColor),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่างกรุณากรอกให้ครบ');
            } else {
              checkAuthen();
            }
          }),
    );
  }

  Future<Null> checkAuthen() async {
    var url = 'http://75ecb40ea4f9.ngrok.io/condb_food/getUserWhereUser.php?isAdd=true&User=$user';
       //'http://192.168.2.184:8080/condb_food/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print("result = $result");
      for (var map in result) {
        //ในการวนลูป 1 รอบ จะโยนค่า Map ไปที่ Model
        UserModel userModel = UserModel.fromJson(map);
        //เปรียบเทียบว่า password ตรงกับที่ลงทะเบียนมั้ย ถ้าตรงไปหน้าใหม่ / ไม่ตรง ให้แจ้งเตือน
        if (password == userModel.password) {
          var choooseType = userModel.chooseType;
          if (choooseType == 'Customer') {
            routeToService(MainUser(), userModel);
          }else if(choooseType == 'Shop owner'){
            routeToService(MainShop(), userModel);
          }else{
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'Password ผิด กรุณาลองใหม่');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);

    //เก็บ preferent ก่อน login เพื่อให้คงอยู่ในระบบตลอด ตอนออกแอพแล้วเข้าใหม่จะไม่ต้อง loginใหม่
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidget);
    //เปลี่ยนหน้าแล้วย้อนกลับไม่ได้
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
