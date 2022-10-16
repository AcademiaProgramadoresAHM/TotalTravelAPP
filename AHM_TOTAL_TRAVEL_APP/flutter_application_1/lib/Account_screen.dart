// ignore_for_file: prefer_const_constructors

import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Screens/EditAccount.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/hotel_booking/calendar_popup_view.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/hotel_booking/hotel_list_view.dart';
import 'package:flutter_application_1/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'hotel_booking/filters_screen.dart';
import 'hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'main.dart';
import 'dart:convert';
import 'package:flutter/src/rendering/box.dart';

class AccountInfo extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const AccountInfo(this.userloggeddata, {Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfo();
}

class _AccountInfo extends State<AccountInfo> with TickerProviderStateMixin {
  AnimationController? animationController;
  var _sexo = "M";
  bool evaluate = false;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  //UserListViewModel? _userData;
  var _userData;

  @override
  void initState() {
    // userData =
    //     GetUserData(widget.userloggeddata!.ID, widget.userloggeddata!.Token);
    //userData =
    //GetUserData(widget.userloggeddata!.ID, widget.userloggeddata!.Token)
    //  .then((value) => {userData = UserListViewModel.fromJson(value)});
    //userData = UserListViewModel.;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    GetUserData();
  }

  Future<void> GetUserData() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Users/Find?id=" +
            widget.userloggeddata!.ID.toString();
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final respuesta = await http.get(Uri.parse(url_list), headers: headers);
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(respuesta.body);
      var data = userMap['data'];
      setState(() {
        _userData = data;
      });
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  Container(
                    child: Form(
                      /*Contenido*/
                      child: Column(
                        children: <Widget>[
                          ProfilePic(),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 240.0, top: 70.0),
                            child: Text(
                              'Nombre',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0, right: 140.0),
                            child: Text(
                              _userData['nombre'],
                              //_userData?.nombre_completo ?? 'nulo',
                              //widget.userloggeddata?.nombre_completo ?? 'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 240.0, top: 20.0),
                            child: Text(
                              'Apellido',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0, right: 140.0),
                            child: Text(
                              _userData['apellido'],
                              //_userData?.nombre_completo ?? 'nulo',
                              //widget.userloggeddata?.nombre_completo ?? 'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 170.0, top: 20.0),
                            child: Text(
                              'Correo electrónico',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Text(
                              _userData['email'],
                              //'null',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 240.0, top: 20.0),
                            child: Text(
                              'Teléfono',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0, right: 150.0),
                            child: Text(
                              _userData['telefono'],
                              //'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 270.0, top: 20.0),
                            child: Text(
                              'DNI',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0, right: 100.0),
                            child: Text(
                              _userData['dni'],
                              //'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 250.0, top: 20.0),
                            child: Text(
                              'Sexo',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0, right: 130.0),
                            child: Text(
                              _userData['sexo'],
                              //'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 220.0, top: 20.0),
                            child: Text(
                              'Direccion',
                              style: TextStyle(
                                  fontFamily: 'Roboto', fontSize: 17.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Text(
                              _userData['direccion'],
                              //'nulo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            thickness: 02.0,
                            indent: 40.0,
                            endIndent: 40.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0,
                                top: 20.0,
                                bottom: 20.0,
                                left: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(101, 45, 143, 1)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditAccount(widget.userloggeddata)),
                                  );
                                },
                                child: const Text('Editar Cuenta'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                '           ',
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  'Mi Cuenta',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/logo-AHM-Fondo-Morao.png',
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70.0),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 8),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        child: Image.asset(
          'assets/images/userImage.png',
        ),
      ),
    );
  }
}
