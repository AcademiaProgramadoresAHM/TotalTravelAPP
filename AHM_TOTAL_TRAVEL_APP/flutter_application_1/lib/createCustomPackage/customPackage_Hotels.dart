import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HotelDetails.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:http/http.dart' as http;
import '../Models/CitiesViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../utils/models.dart';
import '../utils/AppWidget.dart';
import '../utils/ListaHoteles.dart';

class HotelcustomPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? Ciudad;
  final Map<int?, String> CitiesDictionary;
  const HotelcustomPackage(this.userloggeddata, this.Ciudad,this.CitiesDictionary, {super.key});
  @override
  _HotelcustomPackage createState() => _HotelcustomPackage();
}

class _HotelcustomPackage extends State<HotelcustomPackage> {
  late List<Hoteles> ListaHoteles;
  Map<int?, String> HotelsDictionary = Map();

  Future<dynamic> GetListHotels(Ciudad, userloggeddata,idHotel, bool) async {
    List<dynamic> dataHotels;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Hotels/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);
    var Hotel;
      if(bool == true){
                if (response.statusCode == 200) 
              {
                Map<String, dynamic> userMap = jsonDecode(response.body);
                var Json = DecoderAPI.fromJson(userMap);
                dataHotels = Json.data;
                  Hotel = dataHotels.where((x) => x['ciudadID'] == Ciudad.ID).toList();
                return Hotel;
              }
      }
      else if(bool == false){
         if (response.statusCode == 200) 
         {
            Map<String, dynamic> userMap = jsonDecode(response.body);
            var Json = DecoderAPI.fromJson(userMap);
            dataHotels = Json.data;
            var Hotel = dataHotels.where((x) => x['id'] == idHotel).toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationHomeScreen( HotelDetails(widget.userloggeddata, Hotel,Ciudad,widget.CitiesDictionary),widget.userloggeddata)),
            );
          }
      }
      else{
        print(widget.userloggeddata!.Token);
          final url_list =Uri.parse("https://totaltravelapi.azurewebsites.net/API/Authentication/Refresh-token");
          final headers = {
            "Content-type": "application/json",
            "Authorization": "bearer " + widget.userloggeddata!.Token!
          };
          final json = jsonEncode(widget.userloggeddata!.Token);
          final response = await http.post(url_list, headers: headers, body: json);
          if (response.body != " ") {
            print(response.body);
            widget.userloggeddata!.Token = response.body;
            GetListHotels(Ciudad, userloggeddata,null, true);
          }
      }
  }



  List<Padding> ListHotels(List<dynamic> data, BuildContext context) {
    List<Padding> list = [];
    final _controller = PageController();
    List<String> imageUrl;
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
                          imageUrl[0].toString(),
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
                                      element['hotel'],
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
                                    element['descripcion'],
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
                                            Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFA130),
                                              size: 24,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                '4/5',
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
                                                'Rating',
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
                                          GetListHotels(widget.Ciudad,widget.userloggeddata,element['id'],false);
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
    });

    return list;
  }

  @override
  void initState() {
    super.initState();
    //GetListHotels(widget.Ciudad,widget.userloggeddata);
    ListaHoteles = getHoteles();
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
                  'Hoteles',
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
                        children: ListHotels(snapshot.data, context));
                  } else {
                    return  Center(
                          child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 350, 0, 0),
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 101, 45, 144)),
                      ));
                  }
                },
                future: GetListHotels(widget.Ciudad, widget.userloggeddata,null,true),
          ),
        ],
      )),
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
