import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Components/Decodificador.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';

class EditReservacionTRansport extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final int idciudad;
  final List<dynamic> transport;

  EditReservacionTRansport(this.userloggeddata, this.reservacionEditado,
      this.reservationList, this.idciudad, this.transport);
  @override
  State<EditReservacionTRansport> createState() =>
      _EditReservacionTRansportState();
}

class _EditReservacionTRansportState extends State<EditReservacionTRansport> {
  Future<dynamic> FindTransport(idciudad, userloggeddata, context) async {
    List<dynamic> dataTransport;
    var data;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Transports/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + userloggeddata!.Token!
    };
    var respuesta = await http.get(Uri.parse(url_list), headers: headers);
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = Decodificador.fromJson(ServerResponse);
      dataTransport = Json.data;
      var transport =
          dataTransport.where((x) => x["ciudad_ID"] == idciudad).toList();

      return transport;
      // rellena diccionario de datos
      // data.forEach((x) {
      //   CiudadesViewModel element = CiudadesViewModel.fromJson(x);
      //   var descripcion = element.Ciudad!;
      //   CitiesDictionary[element.ID] = descripcion;
      // });
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  List<Padding> Listrestaurante(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
      imageUrl = element['image_URL'].split(',');
      list.add(Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
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
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl[0].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      element['restaurante'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    "Col. " +
                                        element['colonia'] +
                                        ", Calle " +
                                        element['calle'] +
                                        ", Ave. " +
                                        element['avenida'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                        child: SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                            child: Text("Ver menú",
                                                style: TextStyle(
                                                    color: Color(0xFF652D8F))),
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 0.0),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      101, 45, 143, 1)),
                                        ),
                                        child: Text(
                                          'Reservar',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {},
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
