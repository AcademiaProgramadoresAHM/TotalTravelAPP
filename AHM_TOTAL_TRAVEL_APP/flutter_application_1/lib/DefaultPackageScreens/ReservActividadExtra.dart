import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';

import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import '../createCustomPackage/customPackage_Activities.dart';

class ReservActivitiesExtra extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final ReservationViewmodel Reservation;
  final DefaultPackageModel? package;
  final List<dynamic> paqueteactividades;

  const ReservActivitiesExtra(this.userloggeddata, this.Reservation,
      this.package, this.paqueteactividades,
      {super.key});
  @override
  State<ReservActivitiesExtra> createState() => _ReservActivitiesExtraState();
}

class _ReservActivitiesExtraState extends State<ReservActivitiesExtra> {
  Future<dynamic> GetListActivitiesExtras(
      Ciudad, userloggeddata, idActivity, bool, ActivitiesCount) async {
    List<dynamic> dataActivities;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/ActivitiesExtra/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (bool == true) {
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        var Json = Decodificador.fromJson(userMap);
        dataActivities = Json.data;
        var activity =
            dataActivities.where((x) => x['ciudad_ID'] == Ciudad.ID).toList();

        return activity;
      }
    } else if (bool == false) {
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        var Json = Decodificador.fromJson(userMap);
        dataActivities = Json.data;
        var Activity =
            dataActivities.where((x) => x['id'] == idActivity).toList();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ActivityDetails()),
        // );
      }
    } else {
      print(widget.userloggeddata!.Token);
      final url_list = Uri.parse(
          "https://totaltravelapi.azurewebsites.net/API/Authentication/Refresh-token");
      final headers = {
        "Content-type": "application/json",
        "Authorization": "bearer " + widget.userloggeddata!.Token!
      };

      final json = jsonEncode({"token": widget.userloggeddata!.Token});
      final response = await http.post(url_list, headers: headers, body: json);
      if (response.body != " ") {
        print(response.body);
        widget.userloggeddata!.Token = response.body;
        GetListActivitiesExtras(
            Ciudad, widget.userloggeddata, null, true, ActivitiesCount);
      }
    }
  }

  //Imprimi Listado

  List<Padding> ListActivities(List<dynamic> data, BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
      imageUrl = element['imageURL'].split(',');
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
                                      element['actividad'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    /*Text(
                                      '\$' + element['precio'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color.fromRGBO(101, 45, 143, 1),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),*/
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
                                    element['descripcion'],
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
                                            2, 12, 24, 12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFA130),
                                              size: 24,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                '4/5',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: Text(
                                                'Rating',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 0),
                                          child: SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                              child: Text(
                                                "Ver Detalles",
                                                style: TextStyle(),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                backgroundColor:
                                                    Color(0xFF652D8F),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                // GetListActivitiesExtras(
                                                //     widget.Ciudad,
                                                //     widget.userloggeddata,
                                                //     element['id'],
                                                //     false,
                                                //     widget.ActivitiesAdd);
                                              },
                                            ),
                                          )),
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
