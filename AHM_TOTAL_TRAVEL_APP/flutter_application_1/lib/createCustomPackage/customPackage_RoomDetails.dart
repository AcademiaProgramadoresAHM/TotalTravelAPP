import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HotelRoomsList.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';

class RoomDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Room;
  final CiudadesViewModel Ciudad;
  const RoomDetails(this.userloggeddata, this.Room,this.Ciudad,{Key? key})
      : super(key: key);

  @override
  _RoomDetails createState() => _RoomDetails();
}

class _RoomDetails extends State<RoomDetails> {
  customPackageViewModel customPackageModel = new customPackageViewModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _QuestController;
  TextEditingController? _RoomsController;
  double peopleFinal= 2;
  double rooms = 1;
  String wordPeople = "personas", wordRooms = "habitación";
  bool? ChangeNight, basePrice = true, ChangePeople;
  customPackageViewModel customPackage = new customPackageViewModel();
  var priceBase;
  void SetRooms(roomsNumber, id) {
    setState(() {
      rooms = roomsNumber;
      rooms == 1 ? wordRooms = "habitación" : wordRooms = "habitaciones";
    });
  }

  void SetPeople(peopleNumber) {
    setState(() {
      peopleFinal = peopleNumber;
      peopleFinal == 1 ? wordPeople = "persona" : wordPeople = "personas";
    });
    ChangePeople = true;
    
  }
 

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));
  var nights = 1, previousNight = 1;
  String wordNight = "noche";
  

  List<Padding> RoomDetails(List<dynamic> data, BuildContext context) {
    
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
        nights = difference - 1;
        nights == 0 ? nights = 1: nights = difference - 1;
        nights == 1 ? wordNight = "noche" : wordNight = "noches";
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

      if(basePrice == true){
         priceBase = element['precio'];
         basePrice = false;
      }
    
      if(ChangeNight == true || ChangePeople == true){
        var percentage = priceBase * 0.17;
        var price, peopleSerie;
        peopleSerie = peopleFinal - 2;
        if(nights < previousNight){
        var totalNights = previousNight - nights;
          price = priceBase * totalNights;
        for (var i = 1; i <= peopleSerie; i++) {
            price  = price + percentage;
        }
        }else{
          price = priceBase * nights;
           for (var i = 1; i <= peopleSerie; i++) {
            price  = price + percentage;
        }
      }
        element['precio'] = price;
        ChangeNight = false;
        ChangePeople = false;
      }

      previousNight = nights;

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
                                                      "Seleccione su\nfecha de entrada",
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
                                                                style: TextStyle(color: Color(0xFF652D8F)),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            backgroundColor: Color.fromARGB(255, 234, 234, 234),
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
                                                        shadowColor:Colors.transparent,
                                                        backgroundColor: Color.fromARGB(255, 234, 234, 234),
                                                        padding: EdgeInsets.zero,
                                                      ),
                                                      child: Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(
                                                                dateRange.end),
                                                                style: TextStyle(color: Color(0xFF652D8F)),
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
                                          "Seleccione habitaciones y personas",
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
                                                "${nights} ${wordNight}, ${rooms.round().toString()} ${wordRooms}  ${peopleFinal.round().toString()} ${wordPeople}",
                                                style: TextStyle(color: Color(0xFF652D8F)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                backgroundColor: Color.fromARGB(255, 234, 234, 234),
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
                                                                "Habitaciones",
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
                                                                min: 1,
                                                                max: 10,
                                                                value: rooms,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    SetRooms(value,element['id']);                                                                      
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
                                                                min: 1,
                                                                max: 30.0,
                                                                value: peopleFinal,
                                                                onChanged:
                                                                    (people) {
                                                                 SetPeople(people);
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
                                                                  var roomMax = peopleFinal.toInt() /(rooms.toInt() * element['capacidad']);
                                                      
                                                                  if (roomMax >1) {
                                                                    var quantMax = peopleFinal.toInt() / element['capacidad'];
                                                                    if(quantMax - quantMax.toInt() < 0.5){
                                                                      quantMax  = quantMax + 1;
                                                                    }           
                                                                    showDialog<
                                                                        String>(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                        title:
                                                                            Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 15,
                                                                              left: 20,
                                                                              right: 20),
                                                                          child:
                                                                              Text(
                                                                            'Habitaciones insuficientes',
                                                                            style: TextStyle(
                                                                                color: Color.fromARGB(255, 128, 9, 1),
                                                                                fontSize: 18,
                                                                                fontFamily: 'Outfit',
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                        content: Padding(
                                                                            padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                                                                            child: Text(
                                                                              '¿Desea agregar más habitaciones?',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Outfit',
                                                                                color: Color(0xFF7C8791),
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            )),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context, 'Cancel');
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              'Cancelar',
                                                                              style: TextStyle(color: Color(0xFF7C8791)),
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context, 'OK');


                                                                              SetRooms(quantMax,element['id']);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text('Aceptar'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Aplicar',
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
                                          'HNL ' + element['precio'].toInt().toString() + '.00',
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

    customPackage.usua_ID = widget.userloggeddata!.ID;
    customPackage.hote_ID = element['hotelID'];
    customPackage.reHo_FechaEntrada =  DateFormat('dd-MM-yyyy').format(dateRange.start);
    customPackage.reHo_FechaSalida = DateFormat('dd-MM-yyyy').format(dateRange.end);
    customPackage.reHo_PrecioTotal = element['precio'].toInt().toString();
    customPackage.hote_numeroPersonas = peopleFinal.toInt();
    customPackage.habi_ID = [element['id']];

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
                  children: RoomDetails(widget.Room, context));
            },
          ),
        ],
      )),
       bottomNavigationBar: Row(children: [
        Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child:
        SizedBox( 
          width: 175,
          height: 35,
          child:     ElevatedButton(
          onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Text('¿Esta seguro que desea continuar?',),
          ) ,
          actions: <Widget>[
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          },
           style: ElevatedButton.styleFrom(
            primary:  Color.fromARGB(255, 234, 234, 234),
          ),
          child: Text("Cancelar",style: TextStyle(color: Color(0xFF652D8F)),)),
          ElevatedButton(onPressed: () {
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
            style: TextStyle(fontSize: 18,color: Color(0xFF652D8F)),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 234, 234, 234),
          ),
        ),)
     
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child:
        SizedBox( 
          width: 170,
          child:     ElevatedButton(
          onPressed: () {
          Navigator.push(
                        context,
                    MaterialPageRoute(
                    builder: (context) =>
                         createCustomPackage( widget.Ciudad,widget.userloggeddata,1,customPackage)),);
          },
          child: Text(
            'Confirmar',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF652D8F),
          ),
        ),)
     
      ),
       ],)
     
    );
  }
}
