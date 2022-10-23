import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HotelRoomsList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class RoomDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Room;
  const RoomDetails(this.userloggeddata, this.Room, {Key? key})
      : super(key: key);

  @override
  _RoomDetails createState() => _RoomDetails();
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < minRange) {
      print('value print in between 1 - 20');
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      print('not more 20');
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}

class MyFilter extends TextInputFormatter {
  static final _reg = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}

class _RoomDetails extends State<RoomDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _QuestController;
  TextEditingController? _RoomsController;

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  List<Padding> HotelDetails(List<dynamic> data, BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final difference = dateRange.duration;

    Future pickDateRange() async {
      DateTimeRange? newDataRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: dateRange.start,
        lastDate: DateTime(2100),
      );

      if (newDataRange == null) return;

      setState(() {
        dateRange = newDataRange;
      });
    }

    int intParse(doubleNum) {
    double multiplier = .5;
    return (multiplier * doubleNum).round();
}

    List<Padding> list = [];
    List<String> items = [];
    double people = 2;
    double rooms = 1;
    final _controller = PageController();
    List<String> imageUrl;

    data.forEach((element) {
      for (var i = 1; i <= element['camas']; i++) {
        items.add('${i.toString()}');
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

      imageUrl = element['imageUrl'].split(',');
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
                                            element['habitacion'],
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
                                          element['categoria'],
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
                                          element['descripcion'],
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
                                                      "Entrada",
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF7C8791),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20)),
                                                    ElevatedButton(
                                                      child: Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(start),
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              101, 45, 143, 1),
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0.0,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        backgroundColor:
                                                            Colors.white,
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                      onPressed: pickDateRange,
                                                    )
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
                                                  "Salida",
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF7C8791),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30)),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0.0,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    backgroundColor:
                                                        Colors.white,
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  child: Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(end),
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          101, 45, 143, 1),
                                                    ),
                                                  ),
                                                  onPressed: pickDateRange,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 0, 0),
                                        child: Text(
                                          "N.º de habitaciones y personas",
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF7C8791),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: ElevatedButton(
                                          child: Text(
                                            "${rooms.round().toString()} habitación, ${people.round().toString()} personas",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    101, 45, 143, 1)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            backgroundColor: Colors.white,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 300,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Column(
                                                      children: <Widget>[
 
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      30, 0, 0),
                                                          child: Text(
                                                            "Habitaciones",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Colors.black,
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
                                                            value: 1,
                                                            onChanged: (value) {
                                                                setState(() {
                                                                  rooms = value;
                                                                });
                                                            },
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 30, right: 30),
                                                        ),
                                                         Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      10, 0, 0),
                                                          child: Text(
                                                            "Personas",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Colors.black,
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
                                                            value: 1,
                                                            onChanged: (value) {
                                                                setState(() {
                                                                  people = value;
                                                                });
                                                            },
                                                          ),
                                                          padding:
                                                                 const EdgeInsets
                                                                  .only(left: 30, right: 30, bottom: 10),
                                                        ),
                                                        SizedBox(
                                                          width: 300,
                                                          height:40,
                                                        child: ElevatedButton(
                                                             onPressed: () {
                                                                var roomMax = people.toInt()  / (rooms.toInt() * element['capacidad']);
                                                                if(roomMax > 1){
                                                                   var quantMax = people.toInt() / element['capacidad'];
                                                                   int? quantMaxround = quantMax.ceil();
                                                                   showDialog<String>(
                                                                      context: context,
                                                                      builder: (BuildContext context) => AlertDialog(
                                                                        title: Padding(padding: EdgeInsets.only(top: 15, left: 20, right: 20), child: Text('Habitaciones insuficientes', style: TextStyle(color: Color.fromARGB(255, 128, 9, 1), fontSize: 18, fontFamily: 'Outfit',  fontWeight: FontWeight.w500),),), 
                                                                        content: Padding(padding: EdgeInsets.only(top: 10, left: 0, right: 0), child: Text('¿Desea agregar más habitaciones?', style: TextStyle(
                                                                                        fontFamily: 'Outfit',
                                                                                        color: Color(0xFF7C8791),
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),)),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              Navigator.pop(context, 'Cancel');
                                                      
                                                                            },
                                                                            child: const Text('Cancelar', style: TextStyle(color: Color(0xFF7C8791)),),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              Navigator.pop(context, 'OK');
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Text('Aceptar'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                }else{
                                                                  Navigator.pop(context);
                                                                }
                                                              
                                                             },
                                                            child: Text('Aplicar', style: TextStyle(fontSize: 18),),
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Color(0xFF652D8F),

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
                                      ),
                                    ],
                                  )))
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
              return Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: HotelDetails(widget.Room, context));
            },
          ),
        ],
      )),
    );
  }
}
