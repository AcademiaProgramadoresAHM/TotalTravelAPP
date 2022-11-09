import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/ComponentsLogin/constants.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/Screens/Restaurantes.dart';
import 'package:flutter_application_1/Screens/actividades1.dart';
import 'package:flutter_application_1/Screens/transporte.dart';
import 'package:flutter_application_1/Screens/reservaHotel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Activities.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Hotels.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_PayPage.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Restaurants.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Start.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Transport.dart';
import 'package:flutter_application_1/hotel_booking/calendar_popup_view.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/T7Colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      //home:  createCustomPackage(),
    );
  }
}
  
class createCustomPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final CiudadesViewModel? Ciudad;
  final int? Step;
  final customPackageViewModel customPackage;
  final Map<int?, String> CitiesDictionary;
  const createCustomPackage(this.Ciudad,this.userloggeddata,this.Step, this.customPackage,this.CitiesDictionary, {Key? key, }) : super(key: key);



  @override
  _createCustomPackage createState() => _createCustomPackage();
}
int _currentStep = 0;
class _createCustomPackage extends State<createCustomPackage> {
 int? selectedCity;
  String? selectedValue;
final TextEditingController textEditingController = TextEditingController();
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();




  // the current step
@override
  void initState() {
      StepSet(widget.Step);
    //GetListHotels(widget.Ciudad,widget.userloggeddata);
  }
    void StepSet(Step){
      
    switch (widget.Step) {
      case 0:
        setState(() {
        _currentStep = 0;
      });
        break;
        case 1:
        setState(() {
        _currentStep = 1;
      });
        break;
      case 2:
        setState(() {
        _currentStep = 2;
      });
        break;
          case 3:
        setState(() {
        _currentStep = 3;
      });
        break;
         case 4:
        setState(() {
        _currentStep = 4;
      });
        break;
      default:
        setState(() {
        _currentStep = 0;
      });
    }
    
  }

//Dropdown cities

  int? CitiesDropDownValue;



  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  // Determines whether the stepper's orientation is vertical or horizontal
  // This variable can be changed by using the switch below
  bool _isVerticalStepper = true;

  // This function will be triggered when a step is tapped
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  // This function will be called when the continue button is tapped
  _stepContinue() {
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
  }

  // This function will be called when the cancel button is tapped
  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget getTimeDateUI() {
    return Padding(
      
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Elegir fecha',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xFF652D8F),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 15, 0, 10),
            child: Text(
              'Crea tu paquete',
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
      body: Column(
        children: [
          // Controls the stepper orientation

          const Divider(
            thickness: 2,
            height: 20,
          ),
            Theme(data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(primary: Colors.deepPurple,),
              ), 
            child:  Expanded(
            // the Stepper widget
            child: 
            Stepper(
              margin: EdgeInsetsDirectional.fromSTEB(70,60,50,60),
                controlsBuilder: (context, _) {
                            return 
                              Padding(padding: EdgeInsetsDirectional.fromSTEB(25,0,174,0),
                              child:TextButton(
                                  onPressed: () {
                                      if(_currentStep == 0){
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  NavigationHomeScreen(createPackage(widget.userloggeddata,widget.CitiesDictionary),widget.userloggeddata)),
                                        );
                                      }else{
                                         _stepCancel();
                                      }
                                  },
                                  child: const Text(
                                      'Regresar',
                                    style:
                                      TextStyle(color: Color(0xFF652D8F)),
                                  ),
                                ));
                          },
              // vertical or horizontial
              type: _isVerticalStepper
                  ? StepperType.vertical
                  : StepperType.horizontal,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped:(step){
                  if(step>_currentStep){
                    setState((){
                        _currentStep=step;
                    });
                  }
                },
              onStepContinue: _stepContinue,
              onStepCancel: _stepCancel,
              
              steps: [
                // The first step: Name
                Step(
                  title: const Text('Elegir hotel'),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '     Seleccionar hotel      ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(101, 45, 143, 1),
                          ),
                          onPressed: () {

                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigationHomeScreen( HotelcustomPackage( widget.userloggeddata,widget.Ciudad,widget.CitiesDictionary),widget.userloggeddata)),
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep == 1? StepState.disabled : StepState.complete 
                ),
                  Step(
                  title: const Text('Elegir transporte'),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '     Seleccionar transportes     ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                           onPressed: () {
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
                                  

                                                                  Container(
                                                                      height: 65,
                                                                    decoration: BoxDecoration(color: Colors.white),
                                                                    child:  DropdownButtonHideUnderline(
                                                                            child: DropdownButton2(
                                                                              isExpanded: true,                             
                                                                              hint: Padding(
                                                                                padding: const EdgeInsets.only(left: 30,),
                                                                                child: TextFormField(
                                                                                  style: kTextFormFieldStyle(),
                                                                                  decoration: const InputDecoration(
                                                                                    
                                                                                  // prefixIcon: Icon(Icons.location_on_outlined),
                                                                                    hintText: 'Seleccione una ciudad de salida', hintStyle: TextStyle(fontWeight: FontWeight.bold)
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              items: widget.CitiesDictionary.keys.map((id) {
                                                                                      return DropdownMenuItem(
                                                                                        value: id,
                                                                                        child: Padding(padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                                                                                        child:  Text(widget.CitiesDictionary[id].toString(),), 
                                                                                        ) 
                                                                                      
                                                                                      );
                                                                                    }).toList(),
                                                                                    value: selectedCity,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  selectedCity = value as int?;
                                                                                  CitiesDropDownValue = value;
                                                                                });
                                                                                   CiudadesViewModel element = new CiudadesViewModel(CitiesDropDownValue, null, null, null, null);
                                                                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen(TransportcustomPackage(widget.userloggeddata,element,widget.Ciudad,widget.customPackage,widget.CitiesDictionary),widget.userloggeddata)),);
                                                                               
                                                                              },
                                                                              buttonHeight: 100,
                                                                              buttonWidth: 350,
                                                                              itemHeight: 50,
                                                                              dropdownMaxHeight: 120,
                                                                              searchController: textEditingController,
                                                                              searchInnerWidget: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  top: 0,
                                                                                  bottom: 4,
                                                                                  right: 8,
                                                                                  left: 10,
                                                                                ),
                                                                                
                                                                              ),
                                                                            
                                                                  )),
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
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Elegir actividades'),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '     Seleccionar actividades     ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                           onPressed: () {
                               Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen( customActivities( widget.userloggeddata,widget.Ciudad,0,widget.customPackage,[],widget.CitiesDictionary),widget.userloggeddata)),);
                            
                          },
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Elegir restaurante'),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '      Seleccionar restaurante    ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(101, 45, 143, 1),
                          ),
                          onPressed: () {
                             Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen( RestaurantcustomPackage( widget.userloggeddata,widget.Ciudad,widget.customPackage,0,[],widget.CitiesDictionary),widget.userloggeddata)),);
                          
                          },
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Realizar pago'),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '              Realizar pago                 ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                          onPressed: () {
                                    Navigator.push( context,MaterialPageRoute(builder: (context) =>  NavigationHomeScreen( payPage(widget.customPackage,widget.userloggeddata,widget.Ciudad,widget.CitiesDictionary),widget.userloggeddata)),);
                           
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),),


         

        ],
        
      ),
       
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
