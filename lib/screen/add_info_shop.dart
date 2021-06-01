import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runggyfood/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  //AddInfoShop({Key key}) : super(key: key);

  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add information shop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyStyle().mySizebox(),
            nameForm(),
            MyStyle().mySizebox(),
            addressForm(),
            MyStyle().mySizebox(),
            phoneForm(),
            MyStyle().mySizebox(),
            groupImage(),
            MyStyle().mySizebox(),
            showMap(),
            MyStyle().mySizebox(),
            saveButton()
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.save),
              label: Text('Save Information'),
            ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(13.71784868105841, 100.53907584171766);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);
    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_a_photo,
              size: 36.0,
            )),
        Container(
          width: 200.0,
          child: Image.asset('images/addImage2.png'),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_photo_alternate,
              size: 36.0,
            )),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ชื่อร้านค้า',
                  prefixIcon: Icon(Icons.account_box),
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ที่อยู่ร้านค้า',
                  prefixIcon: Icon(Icons.house),
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'เบอร์ติดต่อร้านค้า',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );
}
