import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HotelDetails.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_TransportSchedules.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import '../Models/CitiesViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/ListaHoteles.dart';

class TransportcustomPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? CiudadSalida;
  final CiudadesViewModel? CiudadLlegada;
  final customPackageViewModel customPackage;
  final Map<int?, String> CitiesDictionary;
  const TransportcustomPackage(this.userloggeddata, this.CiudadSalida,this.CiudadLlegada,this.customPackage,this.CitiesDictionary, {super.key});
  @override
  _TransportcustomPackage createState() => _TransportcustomPackage();
}

class _TransportcustomPackage extends State<TransportcustomPackage> {

  Future<dynamic> GetListTransports(CiudadSalida,CiudadLlegada, userloggeddata,idPartner, bool) async {
    List<dynamic> dataTransport;
    var Transport;
      if(bool == true){
        String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Transports/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
                if (response.statusCode == 200) 
              {
                Map<String, dynamic> userMap = jsonDecode(response.body);
                var Json = DecoderAPI.fromJson(userMap);
                dataTransport = Json.data;
                  Transport = dataTransport.where((x) => x['ciudad_ID'] == CiudadSalida.ID).toList();
                return Transport;
              }
      }
      else if(bool == false){
        String url_list =
        "https://apitotaltravel.azurewebsites.net/API/DetailsTransportation/List";
        final headers = {
          "Content-type": "application/json",
          "Authorization": "bearer " + widget.userloggeddata!.Token!
        };
        final response = await http.get(Uri.parse(url_list), headers: headers);
         if (response.statusCode == 200) 
         {
            Map<String, dynamic> userMap = jsonDecode(response.body);
            var Json = DecoderAPI.fromJson(userMap);
            dataTransport = Json.data;
            var Transport = dataTransport.where((x) => x['ciudad_Llegada_ID'] == CiudadLlegada.ID && x['ciudad_Salida_ID'] == CiudadSalida.ID && x['partner_ID'] == idPartner).toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransportSchedules(widget.userloggeddata,widget.CiudadLlegada,widget.CiudadLlegada,widget.customPackage,Transport,widget.CitiesDictionary)),
            );
          }
      }
      else{
          final url_list =Uri.parse("https://apitotaltravel.azurewebsites.net/API/Authentication/Refresh-token");
          final headers = {
            "Content-type": "application/json",
            "Authorization": "bearer " + widget.userloggeddata!.Token!
          };
          final json = jsonEncode(widget.userloggeddata!.Token);
          final response = await http.post(url_list, headers: headers, body: json);
          if (response.body != " ") {
            widget.userloggeddata!.Token = response.body;
            GetListTransports(widget.CiudadSalida,widget.CiudadLlegada, userloggeddata,null, true);
          }
      }
  }



  List<Padding> ListTransports(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
    if(data.isNotEmpty){
    data.forEach((element) {
      imageUrl = element['image_URL'].split(',');
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
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
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "https://apitotaltravel.azurewebsites.net/Images/"+imageUrl[0].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(101, 45, 143, 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      element['nombrePartner'],
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF090F13),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromRGBO(101, 45, 143, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    "Servicio de transporte" + element['tipoTransporte'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    element['ciudad'],
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
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
                                            2, 12, 24, 12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                          GetListTransports(widget.CiudadSalida,widget.CiudadLlegada,widget.userloggeddata,element['partnerID'],false);
                                        },
                                      ),
                                    ],
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
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(appStore.appBarColor);
    return MaterialApp(
        title: 'Flutter layout demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF652D8F),
            automaticallyImplyLeading: false,
            title: Align(
              alignment: AlignmentDirectional(0, -0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(60, 15, 0, 10),
                child: Text(
                  'Transportes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 23,
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
                  if (snapshot.hasData) {
                    return Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: ListTransports(snapshot.data, context));
                  } else {
                    return  Center(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 101, 45, 144)),
                      ));
                  }
                },
                future: GetListTransports(widget.CiudadSalida,widget.CiudadLlegada, widget.userloggeddata,null,true),
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
        if(widget.customPackage.partner ==  null){
             showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Theme(
                                                data: ThemeData.light(),
                                                child: CupertinoAlertDialog(
                                                  title: Text(
                                                    'Advertencia',
                                                    style: boldTextStyle(
                                                        color: Colors.black,
                                                        size: 18),
                                                  ),
                                                  content: Text(
                                                    'Seleccione un servicio de transporte',
                                                    style: secondaryTextStyle(
                                                        color: Colors.black,
                                                        size: 16),
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                        'Aceptar',
                                                        style: primaryTextStyle(
                                                            color: redColor,
                                                            size: 18),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ));
      }else{
         Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen( createCustomPackage(widget.CiudadSalida,widget.userloggeddata,2,widget.customPackage,widget.CitiesDictionary),widget.userloggeddata)),);
      }
              
            
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
    ));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
