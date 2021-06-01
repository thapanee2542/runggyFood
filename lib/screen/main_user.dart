import 'dart:io';

import 'package:flutter/material.dart';
import 'package:runggyfood/utility/my_style.dart';
import 'package:runggyfood/utility/signout_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  var nameUser;

  @override
  //initstate จะทำงานก่อน build
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }
  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
        //ถ้าเป็นค่า null ให้แสดง main user ถ้าไม่ใช่ให้แสดง 'ชื่อ login'
        title: Text(nameUser == null ? 'Main User ' : '$nameUser login'),
        actions: [IconButton(onPressed:()=> signOutProcess(context),
        icon: Icon(Icons.exit_to_app))],
      ),
      drawer: showDrawer(),
    );
  }
  Drawer showDrawer() => Drawer(
    child: ListView(
      children: [
        showHead(),
      ],
    ),
  );

  UserAccountsDrawerHeader showHead(){
    return UserAccountsDrawerHeader(
      currentAccountPicture: MyStyle().showLogo(),
      decoration: MyStyle().myBoxDecoration('user.png'),
      accountName: Text('Name Login'),
      accountEmail: Text('Login'),
    );
  }



}
