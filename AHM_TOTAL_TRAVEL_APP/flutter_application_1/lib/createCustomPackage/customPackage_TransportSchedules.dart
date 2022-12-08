import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/ComponentsLogin/constants.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Activities.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_TransportDetails.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_spinbox/flutter_spinbox.dart';

class TransportSchedules extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? CiudadSalida;
  final CiudadesViewModel? CiudadLlegada;
  final customPackageViewModel customPackage;
    final Map<int?, String> CitiesDictionary;
  final List<dynamic> transport;
  const TransportSchedules(this.userloggeddata, this.CiudadSalida,this.CiudadLlegada,this.customPackage,this.transport,this.CitiesDictionary,{Key? key})
      : super(key: key);

  @override
  _TransportSchedules createState() => _TransportSchedules();
}
  TimeOfDay time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
class _TransportSchedules extends State<TransportSchedules> {
    int? selectedCity;
  String? selectedValue;
final TextEditingController textEditingController = TextEditingController();
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
      DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool basePrice = true, confirm = false;
  var priceBase;
  var peopleFinal = 1;



  Future<dynamic> GetTransports( userloggeddata,idDetail) async {
   
    List<dynamic> dataTransport;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/DetailsTransportation/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    var Transport;
       if (response.statusCode == 200) 
              {
                Map<String, dynamic> userMap = jsonDecode(response.body);
                var Json = DecoderAPI.fromJson(userMap);
                dataTransport = Json.data;
                  Transport = dataTransport.where((x) => x['id'] == idDetail).toList();

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationHomeScreen( TransportDetails(widget.userloggeddata,widget.customPackage,widget.CiudadSalida, Transport,[],widget.CitiesDictionary),widget.userloggeddata)),
            );
       }
     
  }

  List<Padding> TransportsDetails(List<dynamic> data, BuildContext context) {
  final hours = time.hour.toString().padLeft(2,'0');
  final minutes = time.minute.toString().padLeft(2,'0');


    List<Padding> list = [];
    List<String> items = [];
    List<String> imageUrl;
    final _controller = PageController();
    if(data.isNotEmpty){
    data.forEach((element) {
      imageUrl = element['image_URL'].split(',');
      String? selectedValue;
      if(basePrice == true){
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
                                            0, 20, 0, 0),
                                        child: Text(
                                         "Servicio de transporte  " + element['tipo_Transporte'],
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
                                      0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                      ElevatedButton(
                                        style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromRGBO(
                                                    101, 45, 143, 1)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                        child: Text(
                                          'Reservar',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {
                                          GetTransports(widget.userloggeddata,element['id']);
                                        },
                                      ),
                                    ],
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
    if(confirm == true){

     // widget.activityExtra.insert(widget.ActivityAdd, activitiesExtraModel);
    }
    });}else{
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
    
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF652D8F),
        automaticallyImplyLeading: false,
        title: Row(
              children: <Widget>[
                 
                Material(
                      color:  Color.fromRGBO(101, 45, 143, 1), // button color
                      child: InkWell(
                        splashColor: Color.fromRGBO(101, 45, 143, 1), // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon:  const Icon(
                                         Icons.arrow_back,
                                      ),
                                 onPressed:() {            
                                  Navigator.pop(context);                    
                              },),
                          ],
                        ),
                      ),
                    ),
                
                Padding(padding: EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                child:   Text("Horarios"),
                ),
             
            ]),
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
                  children: TransportsDetails(widget.transport, context));
            },
          ),
        ],
      )),
      
    );
  }
}
