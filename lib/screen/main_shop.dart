import 'package:flutter/material.dart';
import 'package:runggyfood/Widget/information_shop.dart';
import 'package:runggyfood/Widget/list_food_menu_shop.dart';
import 'package:runggyfood/Widget/order_list_shop.dart';
import 'package:runggyfood/utility/my_style.dart';
import 'package:runggyfood/utility/signout_process.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  //Field
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
        title: Text('Main Shop'),
        actions: [
          IconButton(
              onPressed: () => signOutProcess(context),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHead(),
            homeMenu(),
            foodMenu(),
            informationShop(),
            signOut(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายละเอียดการจองของลูกค้า'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหารของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile informationShop() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียดของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = InformationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOut() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign out'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: MyStyle().showLogo(),
      decoration: MyStyle().myBoxDecoration('Shop.png'),
      accountName: Text('Name Shop'),
      accountEmail: Text('Login'),
    );
  }
}
