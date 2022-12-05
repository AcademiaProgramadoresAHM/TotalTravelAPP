import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Decodificador.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'EditReservation_RoomDetails.dart';

class EditReservationHotelRoomList extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final int idHotel;
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
    final Map<int?, String> CitiesDictionary;
  EditReservationHotelRoomList(
    this.userloggeddata,
    this.reservacionEditado,
    this.reservationList,
    this.idHotel,
    this.CitiesDictionary
  );
  @override
  State<EditReservationHotelRoomList> createState() => _MyAppState();
}

class _MyAppState extends State<EditReservationHotelRoomList> {
  Future<dynamic> GetListRooms(Hotel, userloggeddata) async {
    List<dynamic> dataRooms;
    String url_list = "https://totaltravelapi.azurewebsites.net/API/Rooms/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataRooms = Json.data;
      var Room = dataRooms.where((x) => x['hotelID'] == Hotel).toList();

      return Room;
    } else {
      final url_list = Uri.parse(
          "https://totaltravelapi.azurewebsites.net/API/Authentication/Refresh-token");
      final headers = {
        "Content-type": "application/json",
        "Authorization": "bearer " + widget.userloggeddata!.Token!
      };
      final json = jsonEncode({"token: string"});
      final response = await http.post(url_list, headers: headers, body: json);
      if (response.body != " ") {
        widget.userloggeddata!.Token = response.body;
        GetListRooms(Hotel, widget.userloggeddata);
      }
    }
  }

  Future<dynamic> FindRooms(idRoom, userloggeddata) async {
    List<dynamic> dataRoom;
    String url_list = "https://totaltravelapi.azurewebsites.net/API/Rooms/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      dataRoom = Json.data;
      var Room = dataRoom.where((x) => x['id'] == idRoom).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditreservationRoomDetails(
                widget.userloggeddata,
                widget.reservacionEditado,
                widget.reservationList,
                Room,
                widget.CitiesDictionary)),
      );
    } else {}
  }

  List<Padding> ListRooms(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    if (data.isNotEmpty) {
      data.forEach((element) {
        imageUrl = element['imageUrl'].split(',');
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
                                        element['habitacion'],
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 12, 24, 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [],
                                          ),
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
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Ver detalles',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          onPressed: () {
                                            FindRooms(element['id'],
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
    } else {
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(80, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No existen registros.",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
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
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF652D8F),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0.5, -0.05),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10),
            child: Text(
              'Habitaciones Disponiblesl',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional(-0.05, 0.05),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: Image.asset(
                'assets/images/logo-AHM-Fondo-Morao.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(

          // color:
          //     HotelAppTheme.buildLightTheme().backgroundColor,
          child: Column(
        children: [
          FutureBuilder<dynamic>(
            future: GetListRooms(widget.idHotel, widget.userloggeddata),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: CircularProgressIndicator(
                    color: purple,
                  ),
                ));
              } else {
                return Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: ListRooms(snapshot.data, context));
              }
            },
          ),
        ],
      )),
    );
  }
}
