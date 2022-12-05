// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter_application_1/ComponentsLogin/constants.dart';
import 'package:flutter_application_1/ComponentsLogin/controller/simple_ui_controller.dart';
import 'package:flutter_application_1/ComponentsLogin/Recover.dart';
import 'package:flutter_application_1/hotel_booking/calendar_popup_view.dart';
import 'package:flutter_application_1/hotel_booking/hotel_list_view.dart';
import 'package:flutter_application_1/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'hotel_booking/filters_screen.dart';
import 'hotel_booking/hotel_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';

class SupportScreen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const SupportScreen(this.userloggeddata, {Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController shortBioController = TextEditingController();

  final _columnKey = GlobalKey<FormState>();
  var _userData;
  String? name;

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
        name = _userData['nombre'] + ' ' + _userData['apellido'];
      });
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  @override
  void initState() {
    GetUserData();
    super.initState();
  }

  @override
  void dispose() {
    shortBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Get.put(SimpleUIController());

    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getAppBarUI(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFF1F4F8),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(Icons.location_on),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Úbicanos',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Altia Business Park, Bulevar Armenta, San Pedro Sula 21102',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
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
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFF1F4F8),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(Icons.call),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Llámanos',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  '+504 2580-2015',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
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
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFF1F4F8),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(Icons.chat_bubble),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nuestras redes sociales',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Facebook: Agencia TotalTravel \nInstagram: @totalTravel \nWhatsapp: +504 9647-5812',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
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
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
              child: Text(
                'Contáctanos',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF101213),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
              child: Text(
                'Cuentanos en que podemos Ayudarte',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Form(
                key: _columnKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      controller: shortBioController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Escribe tu mensaje aqui...',
                        hintStyle: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 208, 140, 240),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF1F4F8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF101213),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Rellene este campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
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
                          if (_columnKey.currentState!.validate()) {
                            PostEmailContact(
                                shortBioController.text, name, context);
                          }
                          shortBioController.text = "";

                          //
                        },
                        child: const Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
                  'Contáctanos',
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
