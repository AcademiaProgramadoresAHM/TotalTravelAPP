// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
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
import 'package:flutter_application_1/Models/CountriesViewModel.dart';
import 'main.dart';
import 'dart:convert';
import 'package:flutter/src/rendering/box.dart';

UserLoggedModel? userloggeddata;

class AccountInfo extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> userData;
  const AccountInfo(this.userloggeddata, this.userData, {Key? key})
      : super(key: key);

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
  String? name, surname, email, phone, dni, sex, direction;
  String image =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';

  @override
  void initState() {
    GetUserData(widget.userData);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    GetCountries();
    print('aqui el widget' + widget.userData.toString());
  }

  Future<dynamic> dataUserEdit(userloggeddata) async {
    //List<dynamic> userEdit;
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
      //var Json = Decodificador.fromJson(userMap);
      var userEdit = userMap['data'];
      //var dataUserEdit =
      //userEdit.where((x) => x['id'] == userloggeddata.id).toList();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditAccount(widget.userloggeddata, CountriesDictionary)),
      );
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<void> GetUserData(data) async {
    // String url_list =
    //     "https://totaltravelapi.azurewebsites.net/API/Users/Find?id=" +
    //         widget.userloggeddata!.ID.toString();
    // final headers = {
    //   "Content-type": "application/json",
    //   "Authorization": "bearer " + widget.userloggeddata!.Token!
    // };
    // final respuesta = await http.get(Uri.parse(url_list), headers: headers);
    // if (respuesta.statusCode == 200) {
    //   Map<String, dynamic> userMap = jsonDecode(respuesta.body);
    //   var data = userMap['data'];
    print('aqui la data ' + data);
    // setState(() {
    //   _userData = data;
    //   image = _userData['image_URL'];
    //   name = _userData['nombre'];
    //   surname = _userData['apellido'];
    //   email = _userData['email'];
    //   phone = _userData['telefono'];
    //   dni = _userData['dni'];
    //   sex = _userData['sexo'];
    //   direction = 'Colonia ' +
    //       _userData['colonia'] +
    //       ', calle ' +
    //       _userData['calle'] +
    //       ', avenida ' +
    //       _userData['avenida'];
    // });
    // } else {
    //   print("Error: " + respuesta.statusCode.toString());
    // }
  }

  Map<int?, String> CountriesDictionary = Map();
//COUNTRIES
  Future<dynamic> GetCountries() async {
    var data;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Countries/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        CountriesViewModel element = CountriesViewModel.fromJson(x);
        var descripcion = element.Pais!;
        CountriesDictionary[element.ID] = descripcion;
      });
      return Json.data;
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
                          Container(
                              margin: const EdgeInsets.only(top: 70.0),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 8,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(60.0)),
                                child: Image.network(image),
                              )),
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
                            padding: EdgeInsets.only(top: 25.0, right: 195.0),
                            child: Text(
                              name ?? 'Nombre',
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
                            padding: EdgeInsets.only(top: 25.0, right: 195.0),
                            child: Text(
                              surname ?? 'Apellido',
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
                            padding: EdgeInsets.only(top: 25.0, right: 20.0),
                            child: Text(
                              email ?? 'Email',
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
                            padding: EdgeInsets.only(top: 25.0, right: 154.0),
                            child: Text(
                              phone ?? 'Telefono',
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
                              dni ?? 'DNI',
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
                            padding: EdgeInsets.only(top: 25.0, right: 150.0),
                            child: Text(
                              sex ?? 'Sexo',
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
                            padding: EdgeInsets.only(
                                top: 25.0, right: 20.0, left: 40.0),
                            child: Text(
                              direction ?? 'Direccion',
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
                                  dataUserEdit(widget.userloggeddata);
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

// var _userData;
// String? name, surname, email, phone, dni, sex, street, avenue;

// Future<void> GetUserData() async {
//   String url_list =
//       "https://totaltravelapi.azurewebsites.net/API/Users/Find?id=" +
//           userloggeddata!.ID.toString();
//   final headers = {
//     "Content-type": "application/json",
//     "Authorization": "bearer " + userloggeddata!.Token!
//   };
//   final respuesta = await http.get(Uri.parse(url_list), headers: headers);
//   if (respuesta.statusCode == 200) {
//     Map<String, dynamic> userMap = jsonDecode(respuesta.body);
//     var data = userMap['data'];
//     _userData = data;
//   } else {
//     print("Error: " + respuesta.statusCode.toString());
//   }
// }

// class Data {
//   String? name;
//   String? surname;
//   String? email;
//   String? phone;
//   int? dni;
//   String? street;
//   String? avenue;

//   Data(
//       {this.name,
//       this.surname,
//       this.email,
//       this.phone,
//       this.dni,
//       this.street,
//       this.avenue});
// }

// final data = Data(
//     name: _userData['nombre'],
//     surname: _userData['apellido'],
//     email: _userData['email'],
//     phone: _userData['telefono'],
//     dni: _userData['dni'],
//     street: _userData['calle'],
//     avenue: _userData['avenida']);
