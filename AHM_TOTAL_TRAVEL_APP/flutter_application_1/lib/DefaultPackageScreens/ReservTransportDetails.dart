import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Models/CitiesViewModel.dart';
import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../navigation_home_screen.dart';

class ReservTransportDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? CiudadSalida;
  final CiudadesViewModel? CiudadLlegada;
  final Map<int?, String> CitiesDictionary;
  final ReservationViewmodel Reservation;
  final DefaultPackageModel? package;
  final List<dynamic> transport;
  final List<dynamic> paqueteactividades;
  final int? HotelID;
  final double? precio;

  const ReservTransportDetails(
      this.userloggeddata,
      this.Reservation,
      this.CitiesDictionary,
      this.CiudadSalida,
      this.CiudadLlegada,
      this.HotelID,
      this.package,
      this.paqueteactividades,
      this.precio,
      this.transport);

  @override
  State<ReservTransportDetails> createState() => _ReservTransportDetailsState();
}

class _ReservTransportDetailsState extends State<ReservTransportDetails> {
  bool basePrice = true, confirm = false;
  var priceBase;
  var peopleFinal = 1;

  List<Padding> TransportDetails(List<dynamic> data, BuildContext context) {
    int intParse(doubleNum) {
      double multiplier = .5;
      return (multiplier * doubleNum).round();
    }

    List<Padding> list = [];
    List<String> items = [];

    final _controller = PageController();
    List<String> imageUrl;

    data.forEach((element) {
      if (basePrice == true) {
        priceBase = element['precio'];
        basePrice = false;
      }
      String? selectedValue;
      List<DropdownMenuItem<String>> _addDividersAfterItems(
          List<String> items) {
        List<DropdownMenuItem<String>> _menuItems = [];
        for (var item in items) {
          _menuItems.addAll(
            [
              DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              //If it's last item, we will not add Divider after it.
              if (item != items.last)
                const DropdownMenuItem<String>(
                  enabled: false,
                  child: Divider(),
                ),
            ],
          );
        }
        return _menuItems;
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

      imageUrl = element['image_URL'].split(',');
      if (data.isNotEmpty) {
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
                              "https://totaltravelapi.azurewebsites.net/Images/" +
                                  imageUrl[0].toString(),
                              width: 100,
                              height: 300,
                              fit: BoxFit.contain,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              element['parter'],
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            "Servicio de transporte " +
                                                element['tipo_Transporte'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF7C8791),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 10),
                                          child: Text(
                                            "Salida: " +
                                                element['ciudad_Salida'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Text(
                                            "Fecha: " +
                                                element['fecha_Salida']
                                                    .substring(0, 10),
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Text(
                                            "Hora salida: " +
                                                element['hora_Salida'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 20, 0, 0),
                                          child: Text(
                                            "Destino: " +
                                                element['ciudad_Llegada'],
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  75, 20, 0, 0),
                                          child: Text(
                                            "Cantidad de personas",
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  06, 10, 20, 0),
                                          child: SpinBox(
                                            max: widget
                                                .Reservation.resvNumeroPersonas!
                                                .toDouble(),
                                            min: 1,
                                            value: 1,
                                            onChanged: (valuePeople) {
                                              setState(() {
                                                peopleFinal =
                                                    valuePeople.toInt();

                                                element['precio'] =
                                                    priceBase * valuePeople;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  70, 30, 0, 0),
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

      if (confirm == true) {
        reservacionTransporte transporte = new reservacionTransporte();

        transporte.detr_ID = element['id'];
        transporte.reTr_CantidadAsientos = peopleFinal.toInt();

        widget.Reservation.transporteReservacion =
            jsonEncode(transporte) as List<reservacionTransporte>?;
        // widget.customPackage.partner = element['parter'];
        // widget.customPackage.ciudadSalida_ID = element['ciudad_Salida_ID'];
        // widget.customPackage.ciudadSalida = element['ciudad_Salida'];
        // widget.customPackage.ciudadLlegada_ID = element['ciudad_Llegada_ID'];
        // widget.customPackage.ciudadLlegada = element['ciudad_Llegada'];
        // widget.customPackage.horaSalida = element['hora_Salida'];
        // widget.customPackage.tprt_cantidadPersonas = peopleFinal.toInt();
        // widget.customPackage.tprt_Total = element['precio'].toInt();

        // widget.transportList.insert(0, transporte);
        // widget.customPackage.transporteReservacion = widget.transportList;
      }
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
                return Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: TransportDetails(widget.transport, context));
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

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => NavigationHomeScreen(
                      //           createCustomPackage(
                      //               widget.Ciudad,
                      //               widget.userloggeddata,
                      //               2,
                      //               widget.customPackage,
                      //               widget.CitiesDictionary),
                      //           widget.userloggeddata)),
                      // );
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
