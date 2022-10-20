import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:flutter_application_1/Models/HotelsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Screens/Restaurantes.dart';
import 'package:flutter_application_1/Screens/actividades1.dart';
import 'package:flutter_application_1/Screens/transporte.dart';
import 'package:flutter_application_1/Screens/reservaHotel.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Activities.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Hotels.dart';
import 'package:flutter_application_1/createCustomPackage/customPackage_Restaurants.dart';
import 'package:flutter_application_1/hotel_booking/calendar_popup_view.dart';
import '../utils/T7Colors.dart';
import 'package:intl/intl.dart';

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
  const createCustomPackage(this.Ciudad,this.userloggeddata, {Key? key, }) : super(key: key);

  @override
  _createCustomPackage createState() => _createCustomPackage();
}

class _createCustomPackage extends State<createCustomPackage> {
  // the current step
  int _currentStep = 0;
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
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
         title: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                '           ',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70),
              child: Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    'Crear paquete',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/logo-AHM-Fondo-Morao.png', height: 50,),
              ),
            ),
          ],
        ),
        ),
      body: Column(
        children: [
          // Controls the stepper orientation

          const Divider(
            thickness: 2,
            height: 20,
          ),

          Expanded(
            // the Stepper widget
            child: Stepper(
              // vertical or horizontial
              type: _isVerticalStepper
                  ? StepperType.vertical
                  : StepperType.horizontal,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => _stepTapped(step),
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
                              '                 Seleccionar hotel                 ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(101, 45, 143, 1),
                          ),
                          onPressed: () {
                             Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  HotelcustomPackage( widget.userloggeddata,widget.Ciudad)),
                                        );
                          },
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                // The second step: Phone number
                Step(
                  title: const Text('Elegir actividades'),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '             Seleccionar actividades             ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                           onPressed: () {
                             Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  customActivities( widget.userloggeddata,widget.Ciudad)),
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
                // The third step: Verify phone number
                /*Step(
                  title: const Text('Elegir transporte'),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '                 Seleccionar transporte                 ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => transporte()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),*/
                Step(
                  title: const Text('Elegir restaurante'),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '                 Seleccionar restaurante                 ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(101, 45, 143, 1),
                          ),
                          onPressed: () {
                             Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  RestaurantcustomPackage( widget.userloggeddata,widget.Ciudad)),
                                        );
                          
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
                Step(
                  title: const Text('Realizar pago'),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          child: Text(
                              '                 Realizar pago                 ',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 101, 45, 143),
                          ),
                          onPressed: () {
                           /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => hoteles()),
                            );*/
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 4
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
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
