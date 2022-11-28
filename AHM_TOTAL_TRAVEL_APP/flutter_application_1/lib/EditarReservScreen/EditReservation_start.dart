import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Components/Decodificador.dart';
import '../Components/Reservation.dart';
import '../Models/CitiesViewModel.dart';
import '../Models/DefaultPackageViewModel.dart';
import '../Models/ReservationViewModel.dart';
import '../Models/UsersViewModel.dart';
import 'package:http/http.dart' as http;

import '../Screens/Personalizados.dart';
import '../navigation_home_screen.dart';
import 'EditReservation_AcvtivityExtra.dart';
import 'EditReservation_Hotel.dart';
import 'EditReservation_Restaurant.dart';
import 'EditReservation_Transport.dart';
import 'Editreservation_Package.dart';

class EditReservationStart extends StatefulWidget {
  final ReservEdit reservacionEditado;
  final List<dynamic> reservationList;
  final UserLoggedModel? userloggeddata;
  final Map<int?, String> CitiesDictionary;
  EditReservationStart(
      this.userloggeddata, this.reservacionEditado, this.reservationList,this.CitiesDictionary,);
  @override
  State<EditReservationStart> createState() => _EditReservationStartState();
}

class _EditReservationStartState extends State<EditReservationStart> {
  int? selectedCity;
  String? selectedValue;
  int? CitiesDropDownValue;

  Map<int?, String> CitiesDictionary = Map();

  List<Padding> ReservationDetails(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    List<String> items = [];
    final _controller = PageController();
    data.forEach((element) {
      String HotelNombre = element["reservacionDetalle"]["nombre_Hotel"];
      String Transporte = "No hay Transportes Reservados";
      String paquetedescrip =
          element["reservacionDetalle"]["descripcionPaquete"];
      String restaurante = "No hay restaurantes Reservados";
      List<dynamic> listadoActiv = element['actividadesExtras'];
      List<dynamic> Listadorestaurante = element["restaurantes"];
      List<dynamic> ListadoTransportes = element["transportes"];

      if (widget.reservacionEditado.HotelDescrip != null) {
        HotelNombre = widget.reservacionEditado.HotelDescrip.toString();
      }
      if (ListadoTransportes.isNotEmpty) {
        Transporte = ListadoTransportes[0]["details"]["nombre_Transporte"];
      }
      if (Listadorestaurante.isNotEmpty) {
        restaurante = Listadorestaurante[0]["details"]["restaurante"];
      }
      if (widget.reservacionEditado.hoteId == null) {
        widget.reservacionEditado.hoteId =
            element["reservacionDetalle"]["hotel_ID"];
      }
      if (widget.reservacionEditado.usuaId == null) {
        widget.reservacionEditado.usuaId =
            element["reservacionDetalle"]["id_Cliente"];
      }
      if (widget.reservacionEditado.paquId == null) {
        widget.reservacionEditado.paquId =
            element["reservacionDetalle"]["id_Paquete"];
      }
      if (widget.reservacionEditado.resvId == null) {
        widget.reservacionEditado.resvId = element["reservacionDetalle"]["id"];
      }
      if (widget.reservacionEditado.PaqueteDescrip != null) {
        paquetedescrip = widget.reservacionEditado.PaqueteDescrip.toString();
      }

      // String paquetedescrip = element['descripcionPaquete'];
      // String HotelNombre = element['nombre_Hotel'];
      // String RestauranteWord = "Agregar/Cambiar Restaurante";
      // String ActividadesNambe = element[''];
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
                                              paquetedescrip,
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
                                                        widget.CitiesDictionary),
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
                                              HotelNombre,
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
                                            showCupertinoDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    Theme(
                                                      data: ThemeData.light(),
                                                      child:
                                                          CupertinoAlertDialog(
                                                        title: Text(
                                                          'Seguro de Cambiar el Hotel de Hospedaje?',
                                                          style: boldTextStyle(
                                                              color:
                                                                  Colors.black,
                                                              size: 18),
                                                        ),
                                                        content: Text(
                                                          'Al cambiar este registro esta modificando grandemente su reservacion, esto afectara en los precios y actividades que ya tiene reservados',
                                                          style:
                                                              secondaryTextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  size: 16),
                                                        ),
                                                        actions: [
                                                          CupertinoDialogAction(
                                                            child: Text(
                                                              'Regresar',
                                                              style: secondaryTextStyle(
                                                                  color:
                                                                      dodgerBlue,
                                                                  size: 18),
                                                            ),
                                                            onPressed: () {
                                                              finish(context);
                                                            },
                                                          ),
                                                          CupertinoDialogAction(
                                                            child: Text(
                                                              'Continuar',
                                                              style: primaryTextStyle(
                                                                  color: Colors
                                                                      .purple,
                                                                  size: 18),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => EditReservationHotel(
                                                                      widget
                                                                          .userloggeddata,
                                                                      widget
                                                                          .reservacionEditado,
                                                                      widget
                                                                          .reservationList,
                                                                      element['reservacionDetalle']
                                                                          [
                                                                          'ciudad_ID'],
                                                                          widget.CitiesDictionary),
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    )),
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
                                              restaurante,
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
                                                  widget.reservacionEditado,
                                                  widget.reservationList,
                                                  element['reservacionDetalle']
                                                      ['ciudad_ID'],
                                                  [],
                                                  widget.CitiesDictionary
                                                ),
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
                                              listadoActiv[0]["details"]
                                                  ["descripcion"],
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
                                                          [],
                                                          0,
                                                          widget.CitiesDictionary)),
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
                                            0, 20, 40, 0),
                                        child: Text(
                                          "Transporte Reservado",
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
                                              Transporte,
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
                                           /* Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditReservacionTRansport(
                                                          widget.userloggeddata,
                                                          widget.reservacionEditado,
                                                          widget.reservationList,
                                                          element['reservacionDetalle']['ciudad_ID'])),
                                            ),*/
                                            showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 180,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Column(
                                                          children: <Widget>[
                                  

                                                                   Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10),
                                    child: 
                                    Container(
                                      width: 350,
                                      height: 50,
                                    decoration: BoxDecoration(color: Colors.transparent),
                                    child:
                                    DropdownButtonHideUnderline(
                                      child:  DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children: const [
                                                  
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Selecciona una ciudad de salida',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromRGBO(101, 45, 143, 1),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    items: widget.CitiesDictionary.keys.map((id) {
                                      return DropdownMenuItem(
                                          value: id,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 0, 0, 0),
                                            child: Text(
                                              widget.CitiesDictionary[id].toString(),
                                              style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            ),
                                          ));
                                    }).toList(),
                                  value: selectedCity,
                                      onChanged: (value) {
                                                setState(() {
                                              selectedCity = value as int?;
                                             CitiesDropDownValue = value;
                                      });
                                       CiudadesViewModel elementCities = new CiudadesViewModel(CitiesDropDownValue, null, null, null, null);
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditReservacionTRansport(
                                                          widget.userloggeddata,
                                                          widget.reservacionEditado,
                                                          widget.reservationList,
                                                          element['reservacionDetalle']['ciudad_ID'],
                                                          elementCities,
                                                          widget.CitiesDictionary)));
                                    },
                                    icon: const Icon(
                                         Icons.keyboard_double_arrow_down,
                                      ),
                                      iconSize: 20,
                                      iconEnabledColor: Color.fromRGBO(101, 45, 143, 1),
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 70,
                                      buttonWidth: 160,
                                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                        dropdownMaxHeight: 100,
                                        dropdownWidth: 350,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius: const Radius.circular(10),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                  )),

                                  )),
                                                       
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                          },
                                          child: Text(
                                            'Cambiar Transporte',
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
      // widget.reservacionEditado.ciudadID =
      //     element['reservacionDetalle']['ciudad_ID'];
      // widget.reservacionEditado.resvId = element['reservacionDetalle']["id"];
      // widget.reservacionEditado.paquId =
      //     element['reservacionDetalle']["id_Paquete"];
      // widget.reservacionEditado.hoteId =
      //     element['reservacionDetalle']["hotel_ID"];
      // widget.reservacionEditado.usuaId =
      //     element['reservacionDetalle']["id_Cliente"];
      // widget.reservacionEditado.resvPrecio =
      //     element['reservacionDetalle']["precio"];
      // widget.reservacionEditado.resvNumeroPersonas =
      //     element['reservacionDetalle']["numeroPersonas"];
      // widget.reservacionEditado.resvCantidadPagos =
      //     element['reservacionDetalle']["cantidadPagos"];
      // widget.reservacionEditado.reHoFechaEntrada =
      //     element['reservacionDetalle']["fecha_Entrada"];
      // widget.reservacionEditado.reHoFechaSalida =
      //     element['reservacionDetalle']["fecha_Salida"];
      // widget.reservacionEditado.NombreCompleto =
      //     element['reservacionDetalle']['nombrecompleto'];
      // widget.reservacionEditado.dni = element['reservacionDetalle']["dni"];
      // widget.reservacionEditado.resvConfirmacionPago = false;
      // widget.reservacionEditado.resvConfirmacionHotel = false;
      // widget.reservacionEditado.resvConfirmacionRestaurante = false;
      // widget.reservacionEditado.resvConfirmacionTrans = false;
      // widget.reservacionEditado.resvUsuarioModifica =
      //     element['reservacionDetalle']["id_Cliente"];
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
                                    'Esta Seguro de los cambios a realizar?',
                                    style: boldTextStyle(
                                        color: Colors.black, size: 18),
                                  ),
                                  content: Text(
                                    'Se actualiza tu plan de viaje',
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
                                        finish(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'Confirmar',
                                        style: primaryTextStyle(
                                            color: Colors.purple, size: 18),
                                      ),
                                      onPressed: () {
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
