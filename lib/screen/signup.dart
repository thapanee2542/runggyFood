import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:runggyfood/utility/my_style.dart';
import 'package:runggyfood/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          myLogo(),
          MyStyle().mySizebox(),
          showAppName(),
          MyStyle().mySizebox(),
          nameForm(),
          MyStyle().mySizebox(),
          userForm(),
          MyStyle().mySizebox(),
          passwordForm(),
          MyStyle().mySizebox(),
          showTypeUser(),
          MyStyle().mySizebox(),
          registerButton(),
          
        ],
      ),
    );
  }

  Padding showTypeUser() {
    return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border.all(color: MyStyle().darkColor),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        MyStyle().showTitle('Type user :'),
                      ],
                    ),
                  ),
                ),
                MyStyle().mySizebox(),
                userRadioButtton(),
                shopRadioButtton(),
              ],
            ),
          ),
        );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: MyStyle().darkColor),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                print(
                    'name=$name,user=$user,password=$password,chooseType=$chooseType');
                if (name == null ||
                    name.isEmpty ||
                    user == null ||
                    user.isEmpty ||
                    password == null ||
                    password.isEmpty ||
                    chooseType == null ||
                    chooseType.isEmpty) {
                  print('Have space');
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
                } else if (chooseType == null) {
                  normalDialog(context, 'โปรดเลือกชนิดของผู้ลงทะเบียน');
                } else {
                  checkUser();
                }
              }),
        ),
      ],
    );
  }

  Future<Null> checkUser() async {
    var url =
        'http://75ecb40ea4f9.ngrok.io/condb_food/getUserWhereUser.php?isAdd=true&User=$user';
       // 'http://192.168.2.184:8080/condb_food/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(
            context, 'user นี้ $user มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน user ใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    var url =
      'http://75ecb40ea4f9.ngrok.io/condb_food/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
        //'http://192.168.2.184:8080/condb_food/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่');
      }
    } catch (e) {}
  }

  Widget userRadioButtton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: [
                Radio(
                  value: 'Customer',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'Customer',
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget shopRadioButtton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: [
                Radio(
                  value: 'Shop owner',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'Shop owner',
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'password :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('LALALU'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
