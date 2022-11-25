// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
//import 'dart:js';

import 'package:flutter_application_1/Models/TimelineViewModel.dart';
import 'package:flutter_application_1/Screens/Timeline.dart';
import 'package:flutter_application_1/Screens/transporte.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/ReserDetalles.dart';
import 'package:flutter_application_1/introduction_animation/components/center_next_button.dart';
import '../EditarReservScreen/EditReservation_start.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';

import '../Components/Decodificador.dart';
import '../Components/Reservation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class PersonaliScreen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;

  const PersonaliScreen(this.userloggeddata, {super.key});

  @override
  _PersonaliScreenState createState() => _PersonaliScreenState();
}

class _PersonaliScreenState extends State<PersonaliScreen> {
  ReservEdit reservacionEditado = new ReservEdit();
  Future<dynamic> GetListReservation(userloggeddata) async {
    List<dynamic> dataReservation;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Reservation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
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

  Future<dynamic> FindReservationEdit(
      idreservacion, reservacionedit, userloggeddata) async {
    dynamic dataReservation;
    List<dynamic> datarestaurante;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Reservation/Details?id=${idreservacion.toString()}";
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
          "https://apitotaltravel.azurewebsites.net/API/ReservationActivitiesExtra/List";
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
                widget.userloggeddata, reservacionedit, Dato),
          ),
        );
      }
    } else {
      print("Error" + response.statusCode.toString());
    }
  }

  Future<dynamic> FindReservation(idReservation, userloggeddata) async {
    List<dynamic> dataReservation;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Reservation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataReservation = Json.data;
      var reservation =
          dataReservation.where((x) => x['id'] == idReservation).toList();

      TimelineViewModel TimeLineModel = new TimelineViewModel(
          [], 0, '', '', '', 0, '', '', '', '', 0, '', '');
      var id_reservation;
      reservation.forEach((x) {
        id_reservation = x['id'];
      });
      String url_list =
          "https://apitotaltravel.azurewebsites.net/API/Reservation/Find/Timeline?id=" +
              id_reservation.toString();
      final headers = {
        "Content-type": "application/json",
        "Authorization": "bearer " + widget.userloggeddata!.Token!
      };
      final respon = await http.get(Uri.parse(url_list), headers: headers);
      if (respon.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(respon.body);
        var Json = Decodificador.fromJson(userMap);
        var data = Json.data;
        var actividades = data['actividades'];
        TimeLineModel.id_Hotel = data['iD_Hotel'];
        TimeLineModel.Hotel = data['hotel'];
        TimeLineModel.Fecha_Entrada = data['fecha_Entrada'];
        TimeLineModel.Fecha_Salida = data['fecha_Salida'];
        TimeLineModel.iD_Transporte = data['iD_Transporte'];
        TimeLineModel.Transporte = data['transporte'];
        TimeLineModel.Transporte_FechaSalida = data['transporteFechaSalida'];
        var Hora_Salida = data['horaSalida'].toString();
        var Hora_Llegada = data['horaLlegada'].toString();
        TimeLineModel.Hora_Salida =
            Hora_Salida.substring(0, 2) + ':' + Hora_Salida.substring(2, 4);
        TimeLineModel.Hora_Llegada =
            Hora_Llegada.substring(0, 2) + ':' + Hora_Llegada.substring(2, 4);
        TimeLineModel.iD_Cliente = data['iD_Usuario'];
        TimeLineModel.nombre_Cliente = data['nombre'];
        TimeLineModel.apellido_Cliente = data['apellido'];

        var id, actividad, fecha, fullresponse;

        var i = 0;

        List<Actividades> ActividadesList = [];
        actividades.forEach((x) {
          Actividades acti = new Actividades(0, '', '');
          acti.id_actividad = x['id'];
          acti.nombre_actividad = x['actividad'];
          acti.fecha_Actividad = x['fecha'];

          ActividadesList.add(acti);
          TimeLineModel.actividades!.add(acti);
        });
        List<TimelineViewModel> TimeLineList = [];
        TimeLineList.insert(0, TimeLineModel);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Personali2Screen(widget.userloggeddata,
                    reservation, TimeLineList, ActividadesList)));
      }
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> ListDefaultReservation(
      List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();

    data.forEach((element) {
      var splitFecha = element['fecha_Entrada'].toString().split('T');

      var fechaentrada = splitFecha[0];
//////////////////////////////////////////////////////////////
      var splitFechaSalida = element['fecha_Salida'].toString().split('T');

      var fechasalida = splitFechaSalida[0];

      list.add(Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 10, 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x32000000),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 4,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          flex: 100,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text('Paquete :',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 16,
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            )),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  26, 0, 0, 0),
                                          child: Text(
                                            element['descripcionPaquete'],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text('Precio:',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 16,
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            )),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  40, 0, 0, 0),
                                          child: Text(
                                            'L.${element['precio']}',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
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
                                          'Ver Detalles',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {
                                          FindReservation(element['id'],
                                              widget.userloggeddata);
                                        },
                                      ),
                                      ElevatedButton(
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
                                          'Editar Reservation',
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
                ],
              )
            ],
          ),
        ),
      ));
    });

    return list;
  }

  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          title: Row(
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
                    'Reservaciones',
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
        body: SingleChildScrollView(
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
                      children: ListDefaultReservation(snapshot.data, context));
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 101, 45, 144)),
                  ));
                }
              },
              future: GetListReservation(widget.userloggeddata),
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
