import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_HotelRoomsList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RoomDetails extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final List<dynamic> Room;
  const RoomDetails(this.userloggeddata, this.Room, {Key? key}) : super(key: key);

  @override
  _RoomDetails createState() => _RoomDetails();
}

class _RoomDetails extends State<RoomDetails> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? _QuestController;


  


List<Padding> HotelDetails(List<dynamic> data, BuildContext context) {

  
  List<Padding> list = [];
  List<String> items = [];
  final _controller = PageController();
  List<String> imageUrl;
  
  data.forEach((element) {

    for (var i = 1; i <= element['camas']; i++) {
     items.add('${i.toString()}');
    }

String? selectedValue;

List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
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
    list.add(Padding(
      padding: EdgeInsetsDirectional.fromSTEB(18, 14, 18,0),
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
        child: 
        Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0,0, 0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  element['categoria'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  element['descripcion'],
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                              /*Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text("Huespedes", style: TextStyle(
                                              fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500, )
                                    )
                                         
                                         ),
                                         
                                      ],
                                    )
                                  ],
                                ),
                                  
                              ),*/ Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text("Huespedes", style: TextStyle(
                                              fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500, ))
                                         
                                         ),
                                         Padding(padding: EdgeInsets.only(left: 120)),
                                          Expanded(
                                          child: Text("Camas", style: TextStyle(
                                              fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500, ))
                                         
                                         ),
                                      ],
                                    )
                                  ],
                                ),
                                  
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Form(
                                      child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child:TextFormField(
                                              controller: _QuestController,
                                              decoration: InputDecoration(
                                                          focusColor: Colors.white,
                                                          border: InputBorder.none,
                                                          //add prefix icon
                                                          prefixIcon: Icon(
                                                            Icons.person_outline_rounded,
                                                            color: Colors.grey,
                                                          )),
                                              validator: (value) {
                                                String? err = (value);
                                                if (err != null) {
                                                 return "Ingrese una cantidad";
                                                }
                                                return err;
                                              },
                                              
                                            )),
                                         Expanded(
                                            flex: 2,
                                          child: Text(" "),
                                         ),
                                    
                                          Expanded(
                                            flex: 3,
                                          child: 
                                          DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          '1',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme.of(context).hintColor,
                                                          ),
                                                        ),
                                                        items: _addDividersAfterItems(items),
                                                        customItemsHeights: _getCustomItemsHeights(),
                                                        value: selectedValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedValue = value as String;
                                                          });
                                                        },
                                                        buttonHeight: 50,
                                                        dropdownMaxHeight: 150,
                                                        buttonWidth: 140,
                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                      ),
                                                    ),
                                         ),
                                      ],
                                    ))
                                    
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
                 Padding(padding: EdgeInsets.only(top: 50)),
                              const Divider(
                                  height: 10,
                                  thickness: 10,
                                  indent: 0,
                                  endIndent: 1,
                                  color: Color(0xFFFFC36D),
                                ),
                      Padding(padding: EdgeInsets.only(top: 0)),
                              const Divider(
                                  height: 40,
                                  thickness: 7,
                                  indent: 0,
                                  endIndent: 1,
                                  color: Color.fromARGB(182, 246, 246, 246),
                                ),
                                 
                            
              ],
            )
          ],
        ),
      ),
      
    ),
    
    );
  
  }
  
  );
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: HotelDetails(
                                          widget.Room, context));
                              },

                            ),
                          ],
                        )),
      
    );
  }
}

