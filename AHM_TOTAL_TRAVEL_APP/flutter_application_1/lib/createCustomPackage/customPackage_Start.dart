import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/ComponentsLogin/Edit.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Create.dart';
import 'package:flutter_application_1/createCustomPackage/steppers.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:flutter_application_1/utils/T7Constant.dart';
import 'package:flutter_application_1/utils/prueba2/T2Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import '../ComponentsLogin/Decoder.dart';
import '../ComponentsLogin/constants.dart';
import '../Models/CitiesViewModel.dart';
import '../Models/HotelsViewModel.dart';
import '../Models/UsersViewModel.dart';
import '../main.dart';


class createPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const createPackage(this.userloggeddata, {Key? key}) : super(key: key);


  @override
  _createPackage createState() => _createPackage();
}

class _createPackage extends State<createPackage> {
  int? selectedCity;
  String? selectedValue;
final TextEditingController textEditingController = TextEditingController();
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

 @override
  void initState() {
    super.initState();
    GetCities();
  }



//Dropdown cities

  int? CitiesDropDownValue;
  bool _isVisible1 = false;
  
  void showToast1(bool result) {
    setState(() {
      _isVisible1 = result;
    });
  }


 Future<dynamic> GetListHotels( userloggeddata) async {
    List<dynamic> dataHotels;
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Hotels/List";
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final response = await http.get(Uri.parse(url_list), headers: headers);   
    if (response.statusCode == 200) 
      {
          Map<String, dynamic> userMap = jsonDecode(response.body);
          var Json = DecoderAPI.fromJson(userMap);
          List<dynamic> CardHoteles = [];
        for (var i = 0; i < 4; i++) {
          var JsonList = Json.data.toList();
          CardHoteles.add(JsonList[i]);
        }
        print(CardHoteles);
          return CardHoteles;
      }
      else{
          print("Error " + response.statusCode.toString());
      }
  }

  Map<int?, String> CitiesDictionary = Map();

  Future<dynamic> GetCities() async {
    var data;
    String url_list = "https://totaltravel.somee.com/API/Cities/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        CiudadesViewModel element = CiudadesViewModel.fromJson(x);
        var descripcion = element.Ciudad!;
        CitiesDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
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
                      height: 200,
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
  void dispose() {
    textController?.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
          resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF652D8F),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0.5, -0.05),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 10),
            child: Text(
              'Agencia Total Travel',
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
      body:  
      SingleChildScrollView(

              // color:
              //     HotelAppTheme.buildLightTheme().backgroundColor,
              child: Column(
            children: [
              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20,),
                  child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.5, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                      child: Text(
                        'Reserva tu nueva',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.7, 0),
                    child: Text(
                      'experiencia',
                      style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.30, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Descubre más de tu destino y haz de tu \nviaje lo máximo',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: 330,
                      height: 138,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFFFC36D),
                          width: 5,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 1.00),
                            child: Container(
                              width: 330,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFFFC36D),
                                  width: 6,
                                ),
                              ),
                             child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF652D8F), // backgroundforeground
                                ),
                                onPressed: () async { 
                                  if(CitiesDropDownValue != null){
                                    CiudadesViewModel cityModel = new CiudadesViewModel(CitiesDropDownValue,null,null,null,null);
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  createCustomPackage(cityModel, widget.userloggeddata, null)),
                                        );
                                      
                                  }
                                  

                                },
                                child: Text('Buscar'),
                              ),
                            
                            ),
                          ),
                       Container(
                          height: 65,
                        decoration: BoxDecoration(color: Colors.white),
                         child:  DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,                             
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextFormField(
                                      style: kTextFormFieldStyle(),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.location_on_outlined),
                                        hintText: 'Destino',
                                      ),
                                    ),
                                  ),
                                   items: CitiesDictionary.keys.map((id) {
                                          return DropdownMenuItem(
                                            value: id,
                                            child: Text(CitiesDictionary[id].toString()),
                                          );
                                        }).toList(),
                                         value: selectedCity,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCity = value as int?;
                                       CitiesDropDownValue = value;
                                    });
                                  },
                                  buttonHeight: 100,
                                  buttonWidth: 400,
                                  itemHeight: 50,
                                  dropdownMaxHeight: 200,
                                  searchController: textEditingController,
                                  searchInnerWidget: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 4,
                                      right: 8,
                                      left: 10,
                                    ),
                                     child: TextFormField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Busca un destino',
                                        hintStyle: const TextStyle(fontSize: 17),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return (item.value.toString().contains(searchValue));
                                  },
                                  onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    textEditingController.clear();
                                  }
                                }
                      )),
                       )],
                        
                      ),
                      
                    ),
                    
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 60, 200, 0),
                      child: Text(
                        'Top destinos',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight:FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                    ),
                ],
              ),
              
            ],
          ),
        ),
      ),
                ),
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
                    return Text("");
                  }
                },
                future: GetListHotels( widget.userloggeddata),
              ),
            ],
          )),
    );
  }
}