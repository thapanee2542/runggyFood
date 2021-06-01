import 'package:flutter/material.dart';
import 'package:runggyfood/screen/main_shop.dart';
import 'package:runggyfood/screen/main_user.dart';
import 'package:runggyfood/screen/signIn.dart';
import 'package:runggyfood/screen/signup.dart';
import 'package:runggyfood/utility/my_style.dart';
import 'package:runggyfood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //ถ้า initstate ทำงาน ให้ checkpreference ก่อน
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreference();
  }
   Future<Null> checkPreference() async {
     try {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       var chooseType = preferences.getString('ChooseType');
       //ถ้า chooseType ไม่เป็นค่า null และไม่เป็นช่องว่า
       if (chooseType != null && chooseType.isNotEmpty) {
         if (chooseType == 'Shopper') {
           routeToService(MainUser());
           
         } else if (chooseType == 'Seller'){
           routeToService(MainShop());
         }else{
           normalDialog(context, 'Error User Type');
         }
       }
     } catch (e) {
     }
   }

   void routeToService(Widget myWidget) {
     MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
     Navigator.pushAndRemoveUntil(context, route, (route) => false);
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
      ),
      drawer: showDrawer(),
    );
  }

  //ไอคอน แฮมเบอร์เกอร์
  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  //ปุ่ม Sign In
  ListTile signInMenu() {
    return ListTile(
            leading: Icon(Icons.login,color: MyStyle().darkColor,), 
            title: Text('Sign In'),
            onTap: (){
              Navigator.pop(context);
              MaterialPageRoute route = MaterialPageRoute(builder: (value)=>SignIn());
              Navigator.push(context, route);
            } ,
            );
  }


  //ปุ่ม Sign Up
  ListTile signUpMenu() {
    return ListTile(
            leading: Icon(Icons.create,color: MyStyle().darkColor,), 
            title: Text('Sign Up'),
            onTap: (){
              Navigator.pop(context);
              MaterialPageRoute route = MaterialPageRoute(builder: (value)=>SignUp());
              Navigator.push(context, route);
            } ,
            );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(

      decoration: MyStyle().myBoxDecoration('guest.png'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Guest'), 
      accountEmail: Text('Please Login'));
  }
}
