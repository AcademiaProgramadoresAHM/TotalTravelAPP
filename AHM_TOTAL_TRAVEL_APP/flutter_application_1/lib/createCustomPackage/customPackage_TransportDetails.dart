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
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';

class TransportDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final customPackageViewModel customPackage;
  final CiudadesViewModel? Ciudad;
  final List<dynamic> transport;
  const TransportDetails(this.userloggeddata,this.customPackage,this.Ciudad,this.transport, {Key? key})
      : super(key: key);

  @override
  _TransportDetails createState() => _TransportDetails();
}

class _TransportDetails extends State<TransportDetails> {
  customPackageViewModel customPackageModel = new customPackageViewModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _QuestController;
  TextEditingController? _RoomsController;
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
    if(basePrice == true){
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
                            "https://totaltravel.somee.com/Images/"+imageUrl[0].toString(),
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          "Servicio de transporte " + element['tipo_Transporte'],
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
                                         "Salida: " + element['ciudad_Salida'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                            Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text(
                                         "Fecha: " + element['fecha_Salida'].substring(0,10),
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text(
                                         "Hora salida: " + element['hora_Salida'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                         "Destino: " + element['ciudad_Llegada'],
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                              padding: EdgeInsetsDirectional.fromSTEB(06, 10, 20, 0),
                                                              child: SpinBox(
                                                                max: 10,
                                                                min: 1,
                                                                value: 1,
                                                                onChanged:
                                                                    (valuePeople) {
                                                                  setState(() {
                                                                    peopleFinal = valuePeople.toInt();
                                                                  
                                                                    element['precio'] = priceBase * valuePeople;
                                                                  });
                                                                },
                                                              ),
                                                             
                                                            ),
                                    
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
      reservacionTransporte transporte = new reservacionTransporte();

      transporte.detr_ID = element['id'];
      transporte.reTr_CantidadAsientos = peopleFinal.toInt();
      widget.customPackage.reservacionTransportes = jsonEncode(transporte);
      widget.customPackage.partner = element['parter'];
      widget.customPackage.ciudadSalida_ID = element['ciudad_Salida_ID'];
      widget.customPackage.ciudadSalida = element['ciudad_Salida'];
      widget.customPackage.ciudadLlegada_ID = element['ciudad_Llegada_ID'];
      widget.customPackage.ciudadLlegada = element['ciudad_Llegada'];
      widget.customPackage.horaSalida = element['hora_Salida'];
      widget.customPackage.tprt_cantidadPersonas = peopleFinal.toInt();
      widget.customPackage.tprt_Total = element['precio'].toInt();
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
             Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen( createCustomPackage(widget.Ciudad,widget.userloggeddata,2,widget.customPackage),widget.userloggeddata)),);
          
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
