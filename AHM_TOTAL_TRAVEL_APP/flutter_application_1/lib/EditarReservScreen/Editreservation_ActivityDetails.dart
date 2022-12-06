import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import 'EditReservation_AcvtivityExtra.dart';
import 'EditReservation_start.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';

class EditReservationActivityExtra extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Activity;
  final List<dynamic> reservationList;
  final ReservEdit reservacionEditado;
  final List<ActivitiesExtraDefault>? activityExtra;
  final int ActivitiesAdd;
  final Map<int?, String> CitiesDictionary;
  const EditReservationActivityExtra(
      this.userloggeddata,
      this.reservacionEditado,
      this.reservationList,
      this.activityExtra,
      this.Activity,
      this.ActivitiesAdd,
      this.CitiesDictionary);

  @override
  _ActivityDetails createState() => _ActivityDetails();
}

TimeOfDay time =
    TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

class _ActivityDetails extends State<EditReservationActivityExtra> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool basePrice = true, confirm = false;
  var priceBase;
  var peopleFinal = 1;

  List<Padding> EditReservationActivityExtra(
      List<dynamic> data, BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    List<Padding> list = [];
    List<String> items = [];
    final _controller = PageController();
    data.forEach((element) {
      String? selectedValue;
      if (basePrice == true) {
        priceBase = element['precio'];
        basePrice = false;
      }
      List<double> _getCustomItemsHeights() {
        List<double> _itemsHeights = [];
        for (var i = 0; i < (items.length * 2) - 1; i++) {
          if (i.isEven) {
            _itemsHeights.add(40);
          }
          //Dividers indexes will be the odd indexes
          if (i.isOdd) {
            _itemsHeights.add(4);
          }
        }
        return _itemsHeights;
      }

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
                            element['imageURL'].toString(),
                            width: 100,
                            height: 200,
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
                                            element['actividad'],
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
                                          element['descripcion'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
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
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    234,
                                                                    234,
                                                                    234),
                                                            padding:
                                                                EdgeInsets.zero,
                                                          ),
                                                          onPressed: () async {
                                                            DateTime? newDate =
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
                                                              context: context,
                                                              initialDate: date,
                                                              firstDate: DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100),
                                                              builder: (context,
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
                                                                          Colors
                                                                              .white, // <-- SEE HERE
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
                                                                  child: child!,
                                                                );
                                                              },
                                                            );

                                                            if (newDate == null)
                                                              return;
                                                            setState(() =>
                                                                date = newDate);
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
                                                  max: 10,
                                                  min: 1,
                                                  value: 1,
                                                  onChanged: (valuePeople) {
                                                    setState(() {
                                                      peopleFinal =
                                                          valuePeople.toInt();

                                                      element['precio'] =
                                                          priceBase *
                                                              valuePeople;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
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
                    Padding(padding: EdgeInsets.only(top: 10)),
                    const Divider(
                      height: 10,
                      thickness: 10,
                      indent: 0,
                      endIndent: 1,
                      color: Color(0xFFFFC36D),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

      if (confirm == true) {
        String hour = DateFormat("HH:mm")
            .format(new DateTime(2000, 1, 1, time.hour, time.minute));

        ActivitiesExtraDefault activitiesExtraModel =
            new ActivitiesExtraDefault();
        activitiesExtraModel.acEx_ID = element['id'];
        activitiesExtraModel.acEx_Descripcion = element['actividad'];
        activitiesExtraModel.acEx_numeroPersonas = peopleFinal;
        activitiesExtraModel.reAE_FechaReservacion =
            DateFormat('yyyy-MM-dd').format(date);
        activitiesExtraModel.reAE_HoraReservacion = hour;
        activitiesExtraModel.reAE_Precios = element['precio'];

        int? precioSuma = element['precio'].toString().toInt();
        widget.activityExtra!
            .insert(widget.ActivitiesAdd, activitiesExtraModel);
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
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
                  return Center(
                      child: CircularProgressIndicator(
                    color: purple,
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
                      children: EditReservationActivityExtra(
                          widget.Activity, context));
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
                      setState(() {
                        confirm = true;
                      });
                      widget.reservacionEditado.actividadesExtra =
                          widget.activityExtra;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditReservationActivityExtras(
                                widget.userloggeddata,
                                widget.reservacionEditado,
                                widget.reservationList,
                                widget.activityExtra,
                                widget.ActivitiesAdd,
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
