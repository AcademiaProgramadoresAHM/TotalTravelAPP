import 'dart:convert';

import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/Screens/Personalizados.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_Screen.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:http/http.dart' as http;

import '../Components/Decodificador.dart';
import '../Models/UsersViewModel.dart';
import '../navigation_home_screen.dart';

class Personali2Screen extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Reservation;

  const Personali2Screen(this.userloggeddata, this.Reservation, {super.key});

  @override
  _Personali2ScreenState createState() => _Personali2ScreenState();
}

class _Personali2ScreenState extends State<Personali2Screen> {
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
    List<String> imageUrl;
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: new Text(
                                                'Cantidad personas:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
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
                                          Text('Cantidad de pagos:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
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
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text('Fecha entreda:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                  element['fecha_Entrada'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text('Fecha Salida:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(element['fecha_Salida'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ],
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: new Text('Hotel:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                  element['nombre_Hotel'],
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
                                          Text('Habitacion:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(element['habitacion'],
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
                                            child: Text('Categoria Habitacion:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                  element['categoria_Habitacion']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text('Camas:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(
                                                element['camas'].toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ],
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: new Text('Nombre cliente:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                  element['nombrecompleto'],
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
                                          Text('Dni:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(element['dni'],
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
                                            child: Text('Correo electronico:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(element['email'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text('Telefono:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(
                                                element['telefono'].toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ],
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: TextButton(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
              child: Icon(Icons.arrow_back_ios),
            ),
            title: Text('   Detalles de la Reservacion'),
            backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
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
                    return Text("No data");
                  }
                },
                future: GetListReservationDetails(widget.userloggeddata),
              ),
            ]),
          )),
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
