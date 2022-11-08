import 'package:flutter/material.dart';

import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';

class ReservTransport extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final ReservationViewmodel Reservation;
  final DefaultPackageModel? package;
  final List<dynamic> paqueteactividades;
  final int? HotelID;
  final double? precio;
  final int? reservID;

  ReservTransport(this.userloggeddata, this.Reservation, this.package,
      this.paqueteactividades, this.HotelID, this.precio, this.reservID,
      {super.key});
  @override
  State<ReservTransport> createState() => _ReservTransportState();
}

class _ReservTransportState extends State<ReservTransport> {
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
