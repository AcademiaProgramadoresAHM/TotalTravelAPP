import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Restaurants.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';

class RestaurantDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Restaurant;
  final CiudadesViewModel Ciudad;
  final customPackageViewModel customPackage;
    final int RestaurantsAdd;
  final List<int> listRestaurantsID;
  final List<String> listRestaurants;
  final List<int> listPeopleNumber;
  final List<String> listDateReservation;
  final List<String> listHourReservation;
  const RestaurantDetails(this.userloggeddata, this.Restaurant,this.Ciudad,this.customPackage,this.RestaurantsAdd,this.listRestaurantsID,this.listRestaurants,this.listPeopleNumber,this.listDateReservation,this.listHourReservation,{Key? key})
      : super(key: key);

  @override
  _RestaurantDetails createState() => _RestaurantDetails();
}
  TimeOfDay time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
class _RestaurantDetails extends State<RestaurantDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
      DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool confirm = false;
  var peopleFinal = 1;
   Future<dynamic> GetListMenus(Restaurant,userloggeddata) async {
    List<dynamic> dataMenus;
  String url_list =
      "https://totaltravel.somee.com/API/Menus/List";
       final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
  final response = await http.get(Uri.parse(url_list), headers: headers);
  if (response.statusCode == 200) {
    var imagesMenus;
    Map<String, dynamic> userMap = jsonDecode(response.body);
     var Json = DecoderAPI.fromJson(userMap);
     dataMenus = Json.data;
     var Menus = dataMenus.where((x) => x['iD_Restaurante'] == Restaurant.id).toList();
     Menus.forEach((element) {
      imagesMenus = element['image_Url'];
     });
    return imagesMenus;
    }
  }


  List<Padding> ActivityDetails(List<dynamic> data, BuildContext context) {
  final hours = time.hour.toString().padLeft(2,'0');
  final minutes = time.minute.toString().padLeft(2,'0');
   

    List<Padding> list = [];
    List<String> items = [];
    final _controller = PageController();
    data.forEach((element) {
      String? selectedValue;

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
                            element['image_URL'].toString(),
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
                                            element['restaurante'],
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
                                                          onPressed: () async{
                                                             DateTime? newDate = await showDatePicker(
                                                                context: context, 
                                                                initialDate: date, 
                                                                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                                                lastDate: DateTime(2100),);

                                                                if(newDate == null) return;
                                                                setState(() => date = newDate);
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
                                                 Padding(padding: 
                                                           EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                                                           child: 
                                                            SizedBox(
                                                              width: 130,
                                                              child: ElevatedButton(
                                                              child: Text( '${hours}:${minutes}', style:  TextStyle(color: Color(0xFF652D8F))),
                                                              onPressed: () async{
                                                                TimeOfDay? newTime = 
                                                                await showTimePicker(
                                                                  cancelText: "Cancelar",
                                                                  confirmText: "Confirmar",
                                                                  context: context, 
                                                                  initialTime: time);

                                                                if(newTime == null) return;
                                                                setState(() => time = newTime);

                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: Color.fromARGB(255, 234, 234, 234),
                                                              ),
                                                              ),
                                                            )
                                                           ),
                                                        
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional .fromSTEB(0,0, 0,0),
                                                              child: Text(
                                                                "Cantidad de personas",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                                    (value) {
                                                                  setState(
                                                                      () {
                                                                        peopleFinal = value.toInt();
                                                                      });
                                                                },
                                                              ),
                                                             
                                                            ),
                                                             Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 220, 0),
                                                              child: Text(
                                                                "Dirección",
                                                                style: TextStyle(
                                                                  fontFamily: 'Outfit',
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                                                              child: Text(
                                                                "Avenida " +
                                                                    element['avenida'] +
                                                                    " Calle " +
                                                                    element['calle'] +
                                                                    " Colonia " +
                                                                    element['colonia'] +
                                                                    ", " +
                                                                    element[
                                                                        'ciudad'] /*element['ciudad'] + "\nCol. " + element['colonia'] + ", Calle " + element['calle'] + ", Ave. " + element['avenida']*/,
                                                                style: TextStyle(
                                                                  fontFamily: 'Outfit',
                                                                  color: Color(0xFF7C8791),
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                            ],
                                          )),
                                  
                                    CarouselSlider(
                                        options: CarouselOptions(height: 200.0),
                                        items: [1,2,3,4,5].map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context).size.width,
                                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                                decoration: BoxDecoration(
                                                ),
                                                child: Image.network(GetListMenus(widget.Restaurant, widget.userloggeddata).toString())
                                              );
                                            },
                                          );
                                        }).toList(),
                                      )

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
      widget.listRestaurantsID.insert(widget.RestaurantsAdd, element['id']);
      widget.listRestaurants.insert(widget.RestaurantsAdd,element['restaurante']);
      widget.listPeopleNumber.insert(widget.RestaurantsAdd,peopleFinal );
      widget.listDateReservation.insert(widget.RestaurantsAdd,DateFormat('dd-MM-yyyy').format(date));
      widget.listHourReservation.insert(widget.RestaurantsAdd, DateFormat("HH:mm").format(new DateTime(2000,1,1,time.hour,time.minute)));

        print(widget.listRestaurantsID);
        print(widget.listRestaurants.toString());
        print(widget.listPeopleNumber);
        print(widget.listDateReservation);
        print(widget.listHourReservation);
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
                  children: ActivityDetails(widget.Restaurant, context));
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
            setState(() {
              confirm = true;
            });
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantcustomPackage(widget.userloggeddata, widget.Ciudad,widget.customPackage,widget.RestaurantsAdd,widget.listRestaurantsID,widget.listRestaurants,widget.listPeopleNumber,widget.listDateReservation,widget.listHourReservation)),
            );
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
