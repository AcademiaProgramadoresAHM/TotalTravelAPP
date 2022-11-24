import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../Components/Decodificador.dart';
import '../ComponentsLogin/Decoder.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'EditReservation_MenuList.dart';
import 'EditReservation_RestaurantDetails.dart';
import 'EditReservation_start.dart';

class EditReservationRestaurante extends StatefulWidget {
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final List<dynamic> Actividadesextras;

  final UserLoggedModel? userloggeddata;
  final int idCiudad;

  EditReservationRestaurante(this.userloggeddata, this.reservacionEditado,
      this.reservationList, this.idCiudad, this.Actividadesextras);
  @override
  State<EditReservationRestaurante> createState() =>
      _EditReservationRestauranteState();
}

class _EditReservationRestauranteState
    extends State<EditReservationRestaurante> {
  Future<dynamic> GetListMenus(
      userloggeddata, idRestaurant, restaurante) async {
    List<dynamic> dataMenus;
    String url_list = "https://apitotaltravel.azurewebsites.net/API/Menus/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = DecoderAPI.fromJson(userMap);
      dataMenus = Json.data;
      var menus =
          dataMenus.where((x) => x['iD_Restaurante'] == idRestaurant).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditReservationMenuList(
                widget.userloggeddata,
                widget.reservacionEditado,
                widget.reservationList,
                menus,
                restaurante)),
      );
    }
  }

  //Encontrar el hotel
  Future<dynamic> FindRestaurant(idRestaurante, userloggeddata) async {
    List<dynamic> datahotel;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Restaurants/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      datahotel = Json.data;
      var restaurant =
          datahotel.where((x) => x['id'] == idRestaurante).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditReservationRestaurantDetails(
                widget.userloggeddata,
                widget.reservacionEditado,
                widget.reservationList,
                restaurant,
                widget.Actividadesextras)),
      );
    } else {
      print("Error" + response.statusCode.toString());
    }
  }

  Future<dynamic> GetListRestaurant(idCiudad, userloggeddata) async {
    List<dynamic> dataHotels;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Restaurants/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    var Hotel;
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataHotels = Json.data;
      Hotel = dataHotels.where((x) => x['ciudadID'] == idCiudad).toList();
      return Hotel;
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
                                            onPressed: () {
                                              GetListMenus(
                                                  widget.userloggeddata,
                                                  element['id'],
                                                  element['restaurante']);
                                            },
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
                                        onPressed: () {
                                          FindRestaurant(element['id'],
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0), // here the desired height
              child: AppBar(
                backgroundColor: Color.fromRGBO(101, 45, 143, 1),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(125, 10, 0, 0),
                        child: Text("Restaurantes"),
                      ),
                      // SizedBox.fromSize(
                      //   size: Size(80, 80), // button width and height
                      //   child: Material(
                      //     color:
                      //         Color.fromRGBO(101, 45, 143, 1), // button color
                      //     child: InkWell(
                      //       splashColor:
                      //           Color.fromRGBO(101, 45, 143, 1), // splash color
                      //       onTap: () {}, // button pressed
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: <Widget>[
                      //           IconButton(
                      //             icon: Container(
                      //               decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       color: Colors.black, width: 1),
                      //                   shape: BoxShape.circle,
                      //                   color:
                      //                       Color.fromARGB(255, 210, 173, 238)),
                      //               child: Center(
                      //                 child: Text(
                      //                   "${widget.RestaurantsAdd}",
                      //                   style: TextStyle(
                      //                       fontSize: 16, color: black),
                      //                 ),
                      //               ),
                      //             ),
                      //             onPressed: () {
                      //               if (widget.RestaurantsAdd != 0) {
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           HistoryRestaurants(
                      //                               widget.userloggeddata,
                      //                               widget.Restaurante,
                      //                               widget.RestaurantsAdd,
                      //                               widget.Ciudad,
                      //                               widget.customPackage,
                      //                               widget.CitiesDictionary)),
                      //                 );
                      //               } else {
                      //                 showCupertinoDialog(
                      //                     context: context,
                      //                     builder: (BuildContext context) =>
                      //                         Theme(
                      //                           data: ThemeData.light(),
                      //                           child: CupertinoAlertDialog(
                      //                             title: Text(
                      //                               'Advertencia',
                      //                               style: boldTextStyle(
                      //                                   color: Colors.black,
                      //                                   size: 18),
                      //                             ),
                      //                             content: Text(
                      //                               'Seleccione un restaurante',
                      //                               style: secondaryTextStyle(
                      //                                   color: Colors.black,
                      //                                   size: 16),
                      //                             ),
                      //                             actions: [
                      //                               CupertinoDialogAction(
                      //                                 child: Text(
                      //                                   'Aceptar',
                      //                                   style: primaryTextStyle(
                      //                                       color: redColor,
                      //                                       size: 18),
                      //                                 ),
                      //                                 onPressed: () {
                      //                                   Navigator.pop(context);
                      //                                 },
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ));
                      //               }
                      //             },
                      //           ),
                      //           Text(
                      //             "Ver Restaurantes",
                      //             style: TextStyle(
                      //                 fontSize: 10, color: Colors.white),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ]),
              ),
            ),
            body: SingleChildScrollView(

                // color:
                //     HotelAppTheme.buildLightTheme().backgroundColor,
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
                          children: Listrestaurante(snapshot.data, context));
                    } else {
                      return Center(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 101, 45, 144)),
                      ));
                    }
                  },
                  future:
                      GetListRestaurant(widget.idCiudad, widget.userloggeddata),
                ),
              ],
            )),
            bottomNavigationBar: Row(
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: SizedBox(
                      width: 175,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () => showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) => Theme(
                                  data: ThemeData.light(),
                                  child: CupertinoAlertDialog(
                                    title: Text(
                                      'Advertencia',
                                      style: boldTextStyle(
                                          color: Colors.black, size: 18),
                                    ),
                                    content: Text(
                                      '¿Está seguro de continuar?',
                                      style: secondaryTextStyle(
                                          color: Colors.black, size: 16),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancelar',
                                          style: primaryTextStyle(
                                              color: dodgerBlue, size: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Aceptar',
                                          style: primaryTextStyle(
                                              color: redColor, size: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                )),
                        child: Text(
                          'Regresar',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF652D8F)),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.reservationList.isEmpty) {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) => Theme(
                                      data: ThemeData.light(),
                                      child: CupertinoAlertDialog(
                                        title: Text(
                                          'Advertencia\n',
                                          style: boldTextStyle(
                                              color: Colors.black, size: 18),
                                        ),
                                        content: Text(
                                          'No ha seleccionado ningún restaurante \n¿Está seguro de continuar?',
                                          style: secondaryTextStyle(
                                              color: Colors.black, size: 16),
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Cancelar',
                                              style: primaryTextStyle(
                                                  color: dodgerBlue, size: 18),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Aceptar',
                                              style: primaryTextStyle(
                                                  color: redColor, size: 18),
                                            ),
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           NavigationHomeScreen(
                                              //               createCustomPackage(
                                              //                   widget.Ciudad,
                                              //                   widget
                                              //                       .userloggeddata,
                                              //                   4,
                                              //                   widget
                                              //                       .customPackage,
                                              //                   widget
                                              //                       .CitiesDictionary),
                                              //               widget
                                              //                   .userloggeddata)),
                                              // );
                                            },
                                          )
                                        ],
                                      ),
                                    ));
                          } else {
                            // widget.reservacionEditado.Restaurante =
                            //     widget.Restaurante;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditReservationStart(
                                      widget.userloggeddata,
                                      widget.reservacionEditado,
                                      widget.reservationList,
                                      widget.Actividadesextras)),
                            );
                          }
                        },
                        child: Text(
                          'Confirmar',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF652D8F),
                        ),
                      ),
                    )),
              ],
            )));
  }
}
