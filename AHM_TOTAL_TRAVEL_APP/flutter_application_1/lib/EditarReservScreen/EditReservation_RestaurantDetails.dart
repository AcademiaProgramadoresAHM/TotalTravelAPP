import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Components/Decodificador.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import '../Models/customPackageViewModel.dart';
import '../createCustomPackage/customPackage_ActivityDetails.dart';
import 'EditReservation_Restaurant.dart';
import 'EditReservation_start.dart';

class EditReservationRestaurantDetails extends StatefulWidget {
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final UserLoggedModel? userloggeddata;
  final int idCiudad;
  final List<dynamic> restaurante;
  final List<Restaurants> Restaurante;
      final Map<int?, String> CitiesDictionary;
  EditReservationRestaurantDetails(this.userloggeddata, this.reservacionEditado,
      this.reservationList, this.restaurante, this.Restaurante, this.idCiudad, this.CitiesDictionary);
  @override
  State<EditReservationRestaurantDetails> createState() => _MyAppState();
}

class _MyAppState extends State<EditReservationRestaurantDetails> {
  var peopleFinal = 1;
  int contador = 0;
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<dynamic> GetListadoRestauranteEdit() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Restaurants/List";
    final response = await http.get(Uri.parse(url_list));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = Decodificador.fromJson(userMap);
      return user.data;
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  List<Padding> RestaurantDetails(List<dynamic> data, BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    data.forEach((element) {
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(18, 10, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl[0].toString(),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 5, 0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  Text(
                                                    element['restaurante'],
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 16, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Seleccione su fecha",
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20)),
                                                      SizedBox(
                                                          width: 130,
                                                          child: ElevatedButton(
                                                            child: Text(
                                                              '${date.day}-${date.month}-${date.year}',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF652D8F)),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 0.0,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          234,
                                                                          234,
                                                                          234),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              DateTime?
                                                                  newDate =
                                                                  await showDatePicker(
                                                                helpText:
                                                                    'Selecciona una fecha', // Can be used as title
                                                                cancelText:
                                                                    'Cancelar',
                                                                confirmText:
                                                                    'Aceptar',
                                                                fieldLabelText:
                                                                    'Ingresa una fecha',
                                                                fieldHintText:
                                                                    'Día/Mes/Año',
                                                                context:
                                                                    context,
                                                                initialDate: DateTime
                                                                    .parse(widget
                                                                        .reservacionEditado
                                                                        .reHoFechaEntrada!),
                                                                firstDate: DateTime
                                                                    .parse(widget
                                                                        .reservacionEditado
                                                                        .reHoFechaEntrada!),
                                                                lastDate: DateTime
                                                                    .parse(widget
                                                                        .reservacionEditado
                                                                        .reHoFechaSalida!),
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return Theme(
                                                                    data: Theme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      colorScheme:
                                                                          ColorScheme
                                                                              .light(
                                                                        primary: Color.fromRGBO(
                                                                            101,
                                                                            45,
                                                                            143,
                                                                            1), // <-- SEE HERE
                                                                        onPrimary:
                                                                            Colors.white, // <-- SEE HERE
                                                                        onSurface: Color.fromRGBO(
                                                                            101,
                                                                            45,
                                                                            143,
                                                                            1), // <-- SEE HERE
                                                                      ),
                                                                      textButtonTheme:
                                                                          TextButtonThemeData(
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          primary: Color.fromRGBO(
                                                                              101,
                                                                              45,
                                                                              143,
                                                                              1), // button text color
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        child!,
                                                                  );
                                                                },
                                                              );

                                                              if (newDate ==
                                                                  null) return;
                                                              setState(() =>
                                                                  date =
                                                                      newDate);
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(top: 0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(11, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Seleccione su hora       ",
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 10,
                                                                    0, 20),
                                                        child: SizedBox(
                                                          width: 130,
                                                          child: ElevatedButton(
                                                            child: Text(
                                                                '${hours}:${minutes}',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF652D8F))),
                                                            onPressed:
                                                                () async {
                                                              TimeOfDay?
                                                                  newTime =
                                                                  await showTimePicker(
                                                                helpText:
                                                                    'Selecciona una hora', // Can be used as title
                                                                cancelText:
                                                                    "Cancelar",
                                                                confirmText:
                                                                    "Confirmar",
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    time,
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return Theme(
                                                                    data: Theme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      colorScheme:
                                                                          ColorScheme
                                                                              .light(
                                                                        primary: Color.fromRGBO(
                                                                            101,
                                                                            45,
                                                                            143,
                                                                            1), // <-- SEE HERE
                                                                        onPrimary:
                                                                            Colors.white, // <-- SEE HERE
                                                                        onSurface: Color.fromRGBO(
                                                                            101,
                                                                            45,
                                                                            143,
                                                                            1), // <-- SEE HERE
                                                                      ),
                                                                      textButtonTheme:
                                                                          TextButtonThemeData(
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          primary: Color.fromRGBO(
                                                                              101,
                                                                              45,
                                                                              143,
                                                                              1), // button text color
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        child!,
                                                                  );
                                                                },
                                                              );

                                                              if (newTime ==
                                                                  null) return;
                                                              setState(() =>
                                                                  time =
                                                                      newTime);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          234,
                                                                          234,
                                                                          234),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child: Text(
                                                  "Cantidad de personas",
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(06, 10, 20, 0),
                                                child: SpinBox(
                                                  max: widget.reservacionEditado
                                                      .resvNumeroPersonas!
                                                      .toDouble(),
                                                  min: 1,
                                                  value: 1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      peopleFinal =
                                                          value.toInt();
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 220, 0),
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 10, 30),
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
                                            ],
                                          ),
                                        ),
                                      ]),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(101, 45, 143, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          'Reservar Restaurante',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          contador += 1;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      String hour = hours + minutes;
      Restaurants Restaurant = new Restaurants();
      Restaurant.index = contador;
      Restaurant.rest_ID = element['id'];
      Restaurant.restaurante = element['restaurante'];
      Restaurant.rest_numeroPersonas = peopleFinal.toInt();
      Restaurant.rest_FechaReservacion = DateFormat('yyyy-MM-dd').format(date);
      Restaurant.rest_HoraReservacion = hour;

      widget.Restaurante.insert(contador, Restaurant);
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
              future: GetListadoRestauranteEdit(),
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
                      children: RestaurantDetails(widget.restaurante, context));
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
                      style: TextStyle(fontSize: 18, color: Color(0xFF652D8F)),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditReservationRestaurante(
                                widget.userloggeddata,
                                widget.reservacionEditado,
                                widget.reservationList,
                                widget.idCiudad,
                                widget.Restaurante,
                                widget.CitiesDictionary)),
                      );
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
