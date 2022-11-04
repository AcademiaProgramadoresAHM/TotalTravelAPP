import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Components/Decodificador.dart';
import '../Models/RequestsViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/DefaultPackageViewModel.dart';
import 'ReservationPreview.dart';

class ReservDefaultPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> package;
  const ReservDefaultPackage(this.userloggeddata, this.package, {Key? key})
      : super(key: key);
  @override
  State<ReservDefaultPackage> createState() => _ReservDefaultPackageState();
}

class _ReservDefaultPackageState extends State<ReservDefaultPackage> {
  bool? ChangeNight, basePrice = true, ChangePeople;
  var priceBase;
  String wordPeople = "personas", wordPagos = "Pagos", worldduracion = "Días";

//variables de datos del paquete
  int? idpackage;
  int? hotelId;
  double? precio;
  String? nombrepaque;
  String? DescripPaque;
  String? duracionPaque;
  String? HotelName;
  String? HotelDescrip;
  String? Restaurante;

//Variables de datos de la reservacion
  double people = 2;
  double _pagos = 1;
  int? reservID;

  ReservationViewmodel reservation = new ReservationViewmodel();
  DefaultPackageModel paquete = new DefaultPackageModel();
  DefaultPackageDetailsModel paqueteactividades =
      new DefaultPackageDetailsModel();

  void SetPay(PayNumber) {
    setState(() {
      _pagos = PayNumber;
    });
  }

  void SetPeople(peopleNumber) {
    setState(() {
      people = peopleNumber;
    });
  }

  Future<dynamic> FindPackage(idPackage, userloggeddata) async {
    List<dynamic> datapackage;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/DefaultPackagesDetails/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var Json = Decodificador.fromJson(userMap);
      datapackage = Json.data;
      var packageDetail =
          datapackage.where((x) => x['paqueteID'] == idPackage).toList();

      // paqueteactividades.paqueteId = idpackage;
      // paqueteactividades.nombrePaquete = nombrepaque;
      // paqueteactividades.descripcionPaquete = DescripPaque;
      // paqueteactividades.duracionPaquete = duracionPaque;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReservationPreview(
                  widget.userloggeddata,
                  reservation,
                  paquete,
                  packageDetail,
                  hotelId,
                  precio,
                  reservID)));
      // print(package);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => NavigationHomeScreen(
      //           DetailPackageScreen(widget.userloggeddata, package),
      //           widget.userloggeddata)),
      // );
    } else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> PostReservertion1(
      // int? UsuaID,
      // int? PaquID,
      // bool Personalizado,
      // int CantidadPagos,
      // int NumPersonas,
      // bool ConfrimPago,
      // bool ConfirmHotel,
      // bool ConfirmRestaurant,
      // bool ConfirmTrans,
      // double Precio,
      // String FechaEntrada,
      // String FechaSalida,
      int? HotID,
      ReservationViewmodel reservacion,
      BuildContext context) async {
    // reservation.usuaId = UsuaID;
    // reservation.paquId = PaquID;
    // reservation.resvEsPersonalizado = Personalizado;
    // reservation.resvCantidadPagos = CantidadPagos;
    // reservation.resvNumeroPersonas = NumPersonas;
    // reservation.resvConfirmacionPago = ConfrimPago;
    // reservation.resvConfirmacionHotel = ConfirmHotel;
    // reservation.resvConfirmacionRestaurante = ConfirmRestaurant;
    // reservation.resvConfirmacionTrans = ConfirmTrans;
    // reservation.resvPrecio = Precio;
    // reservation.UsuarioCrea = widget.userloggeddata!.ID;
    // reservation.reHo_FechaEntrada = FechaEntrada;
    // reservation.reHo_FechaSalida = FechaSalida;

    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final uri = Uri.parse(
        "https://totaltravelapi.azurewebsites.net/API/Reservation/Insert");

    final json = jsonEncode(reservacion);
    final response = await http.post(
      uri,
      headers: headers,
      body: json,
    );

    if (response.body != "") {
      print(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var dataInsert = Decodificador.fromJson(userMap);
      if (dataInsert.data != 0) {
        RequestStatus status = RequestStatus.fromJson(dataInsert.data);
        print(status.CodeStatus);
        if (status.CodeStatus! >= 0) {
          reservID = status.CodeStatus!.toInt();
          print(reservID);
          PostReservHotel(
              reservacion.reHo_FechaEntrada,
              reservacion.reHo_FechaSalida,
              reservID!,
              HotID!,
              precio!.toInt(),
              widget.userloggeddata!.ID,
              context);
        }
      }
    }
  }

  Future<void> PostReservHotel(
      String? FechaEntrada,
      String? FechaSalida,
      int ResvID,
      int? HotelID,
      int PrecioTotal,
      int? UsuarioCrea,
      BuildContext context) async {
    ReservHotelModel ReservHotel = new ReservHotelModel();

    ReservHotel.reHoFechaEntrada = FechaEntrada;
    ReservHotel.reHoFechaSalida = FechaSalida;
    ReservHotel.resvId = ResvID;
    ReservHotel.hoteId = HotelID;
    ReservHotel.reHoPrecioTotal = PrecioTotal;
    ReservHotel.reHoUsuarioCreacion = UsuarioCrea;

    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final uri = Uri.parse(
        "https://totaltravelapi.azurewebsites.net/API/ReservationHotels/Insert");
    final json = jsonEncode(ReservHotel);

    final response = await http.post(
      uri,
      headers: headers,
      body: json,
    );

    if (response.body != "") {
      print(response.body);
      print(FechaEntrada);
      print(FechaSalida);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var dataInsert = Decodificador.fromJson(userMap);
      if (dataInsert.data != 0) {
        RequestStatus status = RequestStatus.fromJson(dataInsert.data);
      }
    }
  }

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  List<Padding> ReservDetails(List<dynamic> data, BuildContext context) {
    Future pickDateRange() async {
      DateTimeRange? newDataRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2100),
      );

      if (newDataRange == null) return;

      setState(() {
        dateRange = newDataRange;
        final difference = dateRange.duration.inDays;
        ChangeNight = true;
      });
    }

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
        idpackage = element['id'];
        hotelId = element['iD_Hotel'];
        precio = element['precio'];
        nombrepaque = element['nombre'];
        DescripPaque = element['descripcion_Paquete'];
        duracionPaque = element['duracion_Paquete'];
        HotelName = element['hotel'];
        HotelDescrip = element['descripcion_Hotel'];
        Restaurante = element['restaurante'];
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
                            'https://picsum.photos/seed/786/600',
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
                                            element['nombre'],
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          element['descripcion_Paquete'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          "${element['duracion_Paquete']} ${worldduracion}",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 20,
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
                                                      "Seleccione su\nfecha de llegada",
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
                                                        width: 150,
                                                        child: ElevatedButton(
                                                          child: Text(
                                                            DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(
                                                                    dateRange
                                                                        .start),
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
                                                          onPressed:
                                                              pickDateRange,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Seleccione su\nfecha de salida",
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30)),
                                                SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0.0,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                234, 234, 234),
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                      child: Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(
                                                                dateRange.end),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF652D8F)),
                                                      ),
                                                      onPressed: pickDateRange,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 0, 0),
                                        child: Text(
                                          "Seleccione los Pagos y Personas",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0)),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 0),
                                          child: SizedBox(
                                            width: 300,
                                            child: ElevatedButton(
                                              child: Text(
                                                "${_pagos.round().toString()} ${wordPagos}  ${people.round().toString()} ${wordPeople}",
                                                style: TextStyle(
                                                    color: Color(0xFF652D8F)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                backgroundColor: Color.fromARGB(
                                                    255, 234, 234, 234),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 300,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          30,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                "Cantidad de Pagos a Realizar",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              child: SpinBox(
                                                                max: 10,
                                                                value: _pagos,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    SetPay(
                                                                        value);
                                                                  });
                                                                },
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right:
                                                                          30),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                "Personas",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              child: SpinBox(
                                                                max: 30.0,
                                                                value: people,
                                                                onChanged:
                                                                    (people) {
                                                                  SetPeople(
                                                                      people);
                                                                },
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right: 30,
                                                                      bottom:
                                                                          10),
                                                            ),
                                                            SizedBox(
                                                              width: 300,
                                                              height: 40,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'Confirmar',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Color(
                                                                      0xFF652D8F),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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

      reservation.usuaId = widget.userloggeddata!.ID;
      reservation.paquId = element['id'];
      reservation.resvEsPersonalizado = false;
      reservation.resvCantidadPagos = _pagos.toInt();
      reservation.resvNumeroPersonas = people.toInt();
      reservation.resvConfirmacionPago = false;
      reservation.resvConfirmacionHotel = true;
      reservation.resvConfirmacionRestaurante = false;
      reservation.resvConfirmacionTrans = false;
      reservation.resvPrecio = element['precio'];
      reservation.UsuarioCrea = widget.userloggeddata!.ID;
      reservation.reHo_FechaEntrada =
          DateFormat('yyyy-MM-dd').format(dateRange.start);
      reservation.reHo_FechaSalida =
          DateFormat('yyyy-MM-dd').format(dateRange.end);

      paquete.id = idpackage;
      paquete.nombre = nombrepaque;
      paquete.descripcionPaquete = DescripPaque;
      paquete.duracionPaquete = duracionPaque;
      paquete.precio = precio;
      paquete.hotel = HotelName;
      paquete.descripcionHotel = HotelDescrip;
      paquete.restaurante = Restaurante;
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
                    children: ReservDetails(widget.package, context));
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
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            '¿Esta seguro que desea continuar?',
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 234, 234, 234),
                              ),
                              child: Text(
                                "Cancelar",
                                style: TextStyle(color: Color(0xFF652D8F)),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF652D8F),
                              ),
                              child: Text("Aceptar"))
                        ],
                      ),
                    ),
                    child: Text(
                      'Cancelar',
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
                      FindPackage(idpackage, widget.userloggeddata);
                      // PostReservertion1(
                      //     widget.userloggeddata!.ID,
                      //     idpackage,
                      //     false,
                      //     _pagos.toInt(),
                      //     people.toInt(),
                      //     false,
                      //     false,
                      //     false,
                      //     false,
                      //     precio!,
                      //     DateFormat('yyyy-MM-dd').format(dateRange.start),
                      //     DateFormat('yyyy-MM-dd').format(dateRange.end),
                      //     hotelId,
                      //     context);
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
