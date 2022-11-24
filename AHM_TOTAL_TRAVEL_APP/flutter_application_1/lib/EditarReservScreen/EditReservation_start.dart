import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Components/Decodificador.dart';
import '../Components/Reservation.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import '../Screens/Personalizados.dart';
import '../navigation_home_screen.dart';
import 'EditReservation_AcvtivityExtra.dart';
import 'EditReservation_Hotel.dart';
import 'EditReservation_Restaurant.dart';
import 'Editreservation_Package.dart';

class EditReservationStart extends StatefulWidget {
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final List<dynamic> Actividadesextras;
  final UserLoggedModel? userloggeddata;

  EditReservationStart(this.userloggeddata, this.reservacionEditado,
      this.reservationList, this.Actividadesextras);
  @override
  State<EditReservationStart> createState() => _EditReservationStartState();
}

class _EditReservationStartState extends State<EditReservationStart> {
  Future<dynamic> FindReservationEdit(idreservacion, userloggeddata) async {
    List<dynamic> dataReservation;
    List<dynamic> datarestaurante;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/ReservationRestaurant/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMapa = jsonDecode(response.body);
      var Activ = Decodificador.fromJson(userMapa);
      datarestaurante = Activ.data;
      var restaurante =
          datarestaurante.where((x) => x['resv_ID'] == idreservacion).toList();
      return restaurante;
    } else {
      print("Error" + response.statusCode.toString());
    }
  }

  List<Padding> ReservationDetails(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    List<String> items = [];
    final _controller = PageController();
    data.forEach((element) {
      List<dynamic> listadoActiv = element['actividadesExtras'];
      List<dynamic> Listadorestaurante = element["restaurantes"];
      List<dynamic> ListadoTransportes = element["transportes"];
      // String paquetedescrip = element['descripcionPaquete'];
      // String HotelNombre = element['nombre_Hotel'];
      // String RestauranteWord = "Agregar/Cambiar Restaurante";
      // String ActividadesNambe = element[''];
      // if (widget.reservacionEditado.PaqueteDescrip != null) {
      //   paquetedescrip = widget.reservacionEditado.PaqueteDescrip.toString();
      // }
      // if (widget.reservacionEditado.HotelDescrip != null) {
      //   HotelNombre = widget.reservacionEditado.HotelDescrip.toString();
      // }
      String? selectedValue;
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
                      padding: EdgeInsetsDirectional.fromSTEB(14, 20, 16, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 6,
                              child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            element['reservacionDetalle']
                                                ['nombrecompleto'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 40, 0),
                                        child: Text(
                                          element['reservacionDetalle']['dni'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 40, 0),
                                        child: Text(
                                          "Paquete Seleccionado",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 6,
                                            child: Text(
                                              element['reservacionDetalle']
                                                  ['descripcionPaquete'],
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReservationPackage(
                                                        widget.userloggeddata,
                                                        widget
                                                            .reservacionEditado,
                                                        widget.reservationList,
                                                        widget
                                                            .Actividadesextras),
                                              ),
                                            )
                                          },
                                          child: Text(
                                            'Cambiar Paquete',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF652D8F)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 234, 234, 234),
                                          ),
                                        ),
                                      ),
                                      //Hoteles
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 40, 0),
                                        child: Text(
                                          "Hotel de Hospedaje",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 6,
                                            child: Text(
                                              element['reservacionDetalle']
                                                  ['nombre_Hotel'],
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReservationHotel(
                                                        widget.userloggeddata,
                                                        widget
                                                            .reservacionEditado,
                                                        widget.reservationList,
                                                        element['reservacionDetalle']
                                                            ['ciudad_ID'],
                                                        widget
                                                            .Actividadesextras),
                                              ),
                                            )
                                          },
                                          child: Text(
                                            'Cambiar Hotel',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF652D8F)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 234, 234, 234),
                                          ),
                                        ),
                                      ),
                                      //Restaurantes
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 40, 0),
                                        child: Text(
                                          "Restaurante Reservado",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 6,
                                            child: Text(
                                              Listadorestaurante[0]["details"]
                                                      ["restaurante"] ??
                                                  "No Tiene Restaurante Reservado",
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReservationRestaurante(
                                                        widget.userloggeddata,
                                                        widget
                                                            .reservacionEditado,
                                                        widget.reservationList,
                                                        element['reservacionDetalle']
                                                            ['ciudad_ID'],
                                                        widget
                                                            .Actividadesextras),
                                              ),
                                            )
                                          },
                                          child: Text(
                                            'Cambiar Restaurante',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF652D8F)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 234, 234, 234),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            80, 30, 0, 0),
                                        child: Text(
                                          "Total:     "
                                                  'HNL ' +
                                              element['reservacionDetalle']
                                                      ['precio']
                                                  .toInt()
                                                  .toString() +
                                              '.00',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF090F13),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
      widget.reservacionEditado.ciudadID =
          element['reservacionDetalle']['ciudad_ID'];
    });
    return list;
  }

  List<Padding> ActividadesDetails(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    List<String> items = [];
    final _controller = PageController();
    data.forEach((element) {
      String NombreActividade = element['actividad_Extra'];
      if (widget.reservacionEditado.ActividadesExtDescrip != null) {
        NombreActividade =
            widget.reservacionEditado.ActividadesExtDescrip.toString();
      }

      String? selectedValue;
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
                      padding: EdgeInsetsDirectional.fromSTEB(14, 20, 16, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 6,
                              child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 40, 0),
                                        child: Text(
                                          "Actividades Extras",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 6,
                                            child: Text(
                                              NombreActividade,
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditReservationActivityExtras(
                                                          widget.userloggeddata,
                                                          widget
                                                              .reservacionEditado,
                                                          widget
                                                              .reservationList,
                                                          widget
                                                              .Actividadesextras,
                                                          [],
                                                          0)),
                                            ),
                                          },
                                          child: Text(
                                            'Cambiar Actividades',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF652D8F)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 234, 234, 234),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            80, 30, 0, 0),
                                        child: Text(
                                          "Total:     "
                                                  'HNL ' +
                                              element['precio']
                                                  .toInt()
                                                  .toString() +
                                              '.00',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF090F13),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF652D8F),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.5, -0.05),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 10),
              child: Text(
                'Agencia Total Travel',
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
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                      children:
                          ReservationDetails(widget.reservationList, context));
                }
              },
            ),
            FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                      children: ActividadesDetails(
                          widget.Actividadesextras, context));
                }
              },
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
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) => Theme(
                                data: ThemeData.light(),
                                child: CupertinoAlertDialog(
                                  title: Text(
                                    'Esta Seguro de Volver?',
                                    style: boldTextStyle(
                                        color: Colors.black, size: 18),
                                  ),
                                  content: Text(
                                    'Descartar todos los Cambios Hechos',
                                    style: secondaryTextStyle(
                                        color: Colors.black, size: 16),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Quedarse',
                                        style: secondaryTextStyle(
                                            color: dodgerBlue, size: 18),
                                      ),
                                      onPressed: () {
                                        finish(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Regresar',
                                        style: primaryTextStyle(
                                            color: Colors.purple, size: 18),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NavigationHomeScreen(
                                                    PersonaliScreen(
                                                        widget.userloggeddata),
                                                    widget.userloggeddata),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ));
                    },
                    child: Text(
                      'Regresar',
                      style: TextStyle(fontSize: 18, color: Color(0xFF652D8F)),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 207, 202, 210),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) => Theme(
                                data: ThemeData.light(),
                                child: CupertinoAlertDialog(
                                  title: Text(
                                    'Esta Seguro de Volver?',
                                    style: boldTextStyle(
                                        color: Colors.black, size: 18),
                                  ),
                                  content: Text(
                                    'Descartar todos los Cambios Hechos',
                                    style: secondaryTextStyle(
                                        color: Colors.black, size: 16),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Quedarse',
                                        style: primaryTextStyle(
                                            color: dodgerBlue, size: 18),
                                      ),
                                      onPressed: () {
                                        // FindPackage(idpackage, false,
                                        //     widget.userloggeddata);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Regresar',
                                        style: primaryTextStyle(
                                            color: Colors.purple, size: 18),
                                      ),
                                      onPressed: () {
                                        widget.reservacionEditado
                                            .resvEsPersonalizado = false;
                                        UpdateReservation(
                                            widget.reservacionEditado,
                                            widget.userloggeddata,
                                            context);
                                      },
                                    )
                                  ],
                                ),
                              ));
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
        ));
  }
}
