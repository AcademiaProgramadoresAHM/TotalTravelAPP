import 'package:flutter/material.dart';

class ReservConfirm extends StatefulWidget {
  @override
  State<ReservConfirm> createState() => _ReservConfirmState();
}

class _ReservConfirmState extends State<ReservConfirm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
