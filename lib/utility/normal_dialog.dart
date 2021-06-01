import 'package:flutter/material.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            //แสดงข้อความเตือนเมื่อกรอกข้อมูลในฟอร์มไม่ครบ
            title: Text(message),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context), child: Text('OK')),
                ],
              )
            ],
          ));
}
