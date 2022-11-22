import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Components/Decodificador.dart';
import '../Models/HotelsViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../Screens/EditReservation.dart';
import '../navigation_home_screen.dart';
import 'habitacionesEdit.dart';

class HotelDetailsEdit extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Hotel;
  final ReservEdit? reservacionEditado;
  final List<dynamic> Reservacion;
  final List<dynamic> Actividadespaquete;
  String? PaqueteDescrip;
  double Precio;
  int idpaquete;
  String HotelNombre;

  HotelDetailsEdit(
      this.userloggeddata,
      this.Hotel,
      this.reservacionEditado,
      this.Reservacion,
      this.PaqueteDescrip,
      this.Precio,
      this.idpaquete,
      this.HotelNombre,
      this.Actividadespaquete);
  @override
  State<HotelDetailsEdit> createState() => _HotelDetailsEditState();
}

class _HotelDetailsEditState extends State<HotelDetailsEdit> {
  HotelViewModel? hotelId;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<dynamic> GetHotel() async {
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Hotels/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> HotelDetailsEdit(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
      hotelId = new HotelViewModel(element['id'], null, null, null);
      imageUrl = element['image_URL'].split(',');
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
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            imageUrl[0].toString(),
                            width: 100,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(14, 20, 16, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
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
                                        element['hotel'],
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF090F13),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
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
                    Padding(padding: EdgeInsets.only(top: 50)),
                    const Divider(
                      height: 10,
                      thickness: 10,
                      indent: 0,
                      endIndent: 1,
                      color: Color(0xFFFFC36D),
                    ),
                    Padding(padding: EdgeInsets.only(top: 0)),
                    const Divider(
                      height: 40,
                      thickness: 7,
                      indent: 0,
                      endIndent: 1,
                      color: Color.fromARGB(182, 246, 246, 246),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 220, 0),
                      child: Text(
                        "Dirección",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(35, 20, 10, 30),
                      child: Text(
                        "Avenida " +
                            element['avenida'] +
                            " Calle " +
                            element['calle'] +
                            " Colonia " +
                            element['colonia'] +
                            ", " +
                            element[
                                'ciudad'] /*element['ciudad'] + "\nCol. " + element['colonia'] + ", Calle " + element['calle'] + ", Ave. " + element['avenida']*/,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF7C8791),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(101, 45, 143, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        child: Text(
                          'Seleccionar Hotel',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          widget.reservacionEditado!.hoteId = element['id'];
                          widget.HotelNombre = element['hotel'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomsListEdit(
                                  widget.userloggeddata,
                                  hotelId,
                                  widget.Reservacion,
                                  widget.reservacionEditado,
                                  widget.PaqueteDescrip,
                                  widget.Precio,
                                  widget.idpaquete,
                                  widget.HotelNombre,
                                  widget.Actividadespaquete),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

    return list;
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
              future: GetHotel(),
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
                      children: HotelDetailsEdit(widget.Hotel, context));
                } else {
                  return Center(
                      child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 101, 45, 144)),
                  ));
                }
              },
            ),
          ],
        )),
      ),
    );
  }
}
