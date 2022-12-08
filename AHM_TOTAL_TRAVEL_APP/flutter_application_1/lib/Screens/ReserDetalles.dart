// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/TimelineViewModel.dart';
import 'package:flutter_application_1/Screens/Personalizados.dart';
import 'package:flutter_application_1/Screens/Timeline.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_Screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:http/http.dart' as http;
import '../ComponentsLogin/Decoder.dart';
import '../EditarReservScreen/EditReservation_start.dart';
import '../Models/ReservationViewModel.dart';

import '../Components/Decodificador.dart';
import '../Models/UsersViewModel.dart';
import '../navigation_home_screen.dart';

class Personali2Screen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Reservation;
  final List<TimelineViewModel> timeLineViewModel;
  final List<Actividades> actividadesList;
  const Personali2Screen(this.userloggeddata, this.Reservation,
      this.timeLineViewModel, this.actividadesList,
      {super.key});

  @override
  _Personali2ScreenState createState() => _Personali2ScreenState();
}

class _Personali2ScreenState extends State<Personali2Screen> {
  ReservEdit reservacionEditado = new ReservEdit();
  String? hotel,
      fecha_entrada,
      fecha_salida,
      transporte,
      transporteFechaSalida,
      hora_salida,
      hora_llegada,
      nombre_Cliente,
      apellido_Cliente,
      idActividad,
      nombreActividad,
      fechaActividad;

  Map<int?, String> CitiesDictionary = Map();

  Future<dynamic> GetCities() async {
    var data;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Cities/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        CiudadesViewModel element = CiudadesViewModel.fromJson(x);
        var descripcion = element.Ciudad!;
        CitiesDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<dynamic> FindReservationEdit(
      idreservacion, reservacionedit, userloggeddata) async {
    dynamic dataReservation;
    List<dynamic> datarestaurante;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Reservation/Details?id=${idreservacion.toString()}";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataReservation = Json.data;
      List<dynamic> Dato = [];
      Dato.add(dataReservation);

      url_list =
          "https://totaltravelapi.azurewebsites.net/API/ReservationActivitiesExtra/List";
      final response2 = await http.get(Uri.parse(url_list), headers: headers);
      if (response2.statusCode == 200) {
        Map<String, dynamic> userMapa = jsonDecode(response2.body);
        var Activ = Decodificador.fromJson(userMapa);
        datarestaurante = Activ.data;
        var Actividades = datarestaurante
            .where((x) => x['reservacion'] == idreservacion)
            .toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditReservationStart(
                widget.userloggeddata, reservacionedit, Dato, CitiesDictionary),
          ),
        );
      }
    } else {
      print("Error" + response.statusCode.toString());
    }
  }

  void GetListTimelineReservation() {
    var i = 0;
    widget.timeLineViewModel.forEach((element) {
      // print(element.id_Hotel);
      // print(element.Hotel);
      // print(element.Fecha_Entrada);
      // print(element.Fecha_Salida);
      // print(element.iD_Transporte);
      // print(element.Transporte);
      // print(element.Hora_Salida);
      // print(element.Hora_Llegada);
      // print(element.iD_Cliente);
      // print(element.nombre_Cliente);
      // print(element.apellido_Cliente);
      // print(element.actividades);
      // print(element.actividades);

      setState(() {
        //Sacando solo las fechas
        var fechaEntradaSplit, fechaSalidaSplit, tranFechaSalidaSplit;
        fechaEntradaSplit = element.Fecha_Entrada?.split('T');
        fechaSalidaSplit = element.Fecha_Salida?.split('T');
        tranFechaSalidaSplit = element.Transporte_FechaSalida?.split('T');

        hotel = element.Hotel;
        fecha_entrada = fechaEntradaSplit[0];
        fecha_salida = fechaSalidaSplit[0];
        transporte = element.Transporte;
        transporteFechaSalida = tranFechaSalidaSplit[0];
        hora_salida = element.Hora_Salida;
        hora_llegada = element.Hora_Llegada;
        nombre_Cliente = element.nombre_Cliente;
        apellido_Cliente = element.apellido_Cliente;
      });
    });
    widget.actividadesList.forEach((e) {
      //print("Actividad:" + i.toString());
      idActividad = e.id_actividad.toString();
      nombreActividad = e.nombre_actividad;
      fechaActividad = e.fecha_Actividad;
      i++;
    });
  }

  Future<dynamic> GetListReservationDetails(userloggeddata) async {
    List<dynamic> dataReservation;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Reservation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      print("object");
      GetListTimelineReservation();
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataReservation = Json.data;
      var Reservation = dataReservation
          .where((x) => x['id_Cliente'] == userloggeddata.ID)
          .toList();

      return Reservation;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> ListDetailsReservation(
      List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
/////////////////////////////////////////////

    data.forEach((element) {
      var splitFecha = element['fecha_Entrada'].toString().split('T');
      //print(splitFecha);

      var fechaentrada = splitFecha[0];
      //print(fechaentrada);
//////////////////////// SALIDA//////////////////////////////////////
      var splitFechaSalida = element['fecha_Salida'].toString().split('T');
      //print(splitFechaSalida);

      var fechasalida = splitFechaSalida[0];
      //print(fechasalida);
      list.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x32000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          'Descripcion de paquete:',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        child: Text(
                                                            element['descripcionPaquete'] ??
                                                                "Paquete de Viaje Seleccionado",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          'Cantidad de Personas:',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        child: Text(
                                                            element['numeroPersonas']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          'Cantidad de Pagos:',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        child: Text(
                                                            element['cantidadPagos']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
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
                ),
              ],
            ),
          ),
        ),
      );
    });

/////////////////////////////////////////////
/*
    data.forEach((element) {
      var splitFecha = element['fecha_Entrada'].toString().split('T');
      print(splitFecha);

      var fechaentrada = splitFecha[0];
      print(fechaentrada);
//////////////////////////////////////////////////////////////
      var splitFechaSalida = element['fecha_Salida'].toString().split('T');
      print(splitFechaSalida);

      var fechasalida = splitFechaSalida[0];
      print(fechasalida);

      list.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x32000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Paquete :',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(120, 0, 0, 0),
                                              child: Text(
                                                  element['descripcionPaquete'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                'Cantidad Personas:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(30, 0, 0, 0),
                                              child: Text(
                                                  element['numeroPersonas']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Cantidad de Pagos:',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 0, 0, 0),
                                            child: Text(
                                                element['cantidadPagos']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Precio:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(140, 0, 0, 0),
                                              child: Text(
                                                  element['precio'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
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
                ),
              ],
            ),
          ),
        ),
      );
    });
    */

    data.forEach((element) {
      var splitFecha = element['fecha_Entrada'].toString().split('T');
      //print(splitFecha);

      var fechaentrada = splitFecha[0];
      //print(fechaentrada);
//////////////////////////////////////////////////////////////
      var splitFechaSalida = element['fecha_Salida'].toString().split('T');
      //print(splitFechaSalida);

      var fechasalida = splitFechaSalida[0];
      //print(fechasalida);
      list.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x32000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 20),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text('Hotel:',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(12, 0,
                                                                    0, 0),
                                                        child: Text(
                                                            element[
                                                                'nombre_Hotel'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Fecha Entrada:',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(40, 0, 0, 0),
                                              child: Text(fechaentrada,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Fecha Salida:',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(55, 0, 0, 0),
                                              child: Text(fechasalida,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });

    data.forEach((element) {
      list.add(
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x32000000),
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Nombre Cliente:',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(30, 0, 0, 0),
                                              child: Text(
                                                  element['nombrecompleto'],
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Dni :',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    130, 0, 0, 0),
                                            child: Text(element['dni'],
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Telefono :',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(85, 0, 0, 0),
                                              child: Text(element['telefono'],
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Correo Electronico:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: Text(element['email'],
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 123, 26, 168),
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      101, 45, 143, 1)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Editar Reservación',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {
                                          reservacionEditado.HotelDescrip =
                                              null;
                                          reservacionEditado.PaqueteDescrip =
                                              null;
                                          reservacionEditado
                                              .ActividadesExtDescrip = null;
                                          reservacionEditado.resvId =
                                              element["id"];
                                          reservacionEditado.resvPrecio =
                                              element["precio"];
                                          reservacionEditado
                                                  .resvNumeroPersonas =
                                              element["numeroPersonas"];
                                          reservacionEditado.resvCantidadPagos =
                                              element["cantidadPagos"];
                                          reservacionEditado.reHoFechaEntrada =
                                              element["fecha_Entrada"];
                                          reservacionEditado.reHoFechaSalida =
                                              element["fecha_Salida"];
                                          reservacionEditado.NombreCompleto =
                                              element['nombrecompleto'];
                                          reservacionEditado.dni =
                                              element["dni"];
                                          reservacionEditado
                                                  .resvUsuarioModifica =
                                              element["id_Cliente"];
                                          FindReservationEdit(
                                              element['id'],
                                              reservacionEditado,
                                              widget.userloggeddata);
                                        },
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
                ),
              ],
            ),
          ),
        ),
      );
    });

    return list;
  }

//====================== LINEA DEL TIEMPO - ACTIVIDADES ======================//

  List<ListView> listTimelineReservation(
      List<Actividades> data, BuildContext context) {
    List<ListView> list = [];
    data.forEach((element) {
      var splitFechaActividad = element.fecha_Actividad.toString().split('T');
      var fechaActividad = splitFechaActividad[0];

      list.add(ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x25000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                    child: Container(
                      width: 4,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFFEE8B60),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Actividades',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF101213),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            'Su actividad del dia ' +
                                    element.nombre_actividad! ??
                                'nombre actividad',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            'Fecha: $fechaActividad',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFFEE8B60),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
    });
    return list;
  }

  @override
  void initState() {
    GetListTimelineReservation();
    super.initState();
    GetCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  'Detalles Reservacion',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                FutureBuilder<dynamic>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: ListDetailsReservation(
                              widget.Reservation, context));
                    } else {
                      return Center(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 101, 45, 144)),
                      ));
                    }
                  },
                  future: GetListReservationDetails(widget.userloggeddata),
                ),
                //Empieza la linea del tiempo
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x25000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                          child: Container(
                            width: 4,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(0xFF4B39EF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transporte',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Usted viajara en el transporte' +
                                          transporte! ??
                                      "transporte",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Fecha y hora de salida $transporteFechaSalida $hora_salida',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x25000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                          child: Container(
                            width: 4,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(0xFF39D2C0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hotel',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Usted llegara y habitara el hotel' +
                                          hotel! ??
                                      'hotel',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Fecha y hora de llegada: $fecha_entrada $hora_llegada',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF39D2C0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children:
                      listTimelineReservation(widget.actividadesList, context),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x25000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                          child: Container(
                            width: 4,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(0xFF39D2C0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hotel',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Desalojará el hotel ' + hotel! ??
                                      'hotel' + 'el dia: ',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  fecha_salida! ?? 'fecha salida',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF39D2C0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
