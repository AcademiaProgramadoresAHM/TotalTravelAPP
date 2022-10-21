import 'dart:io';

import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:ddlog/ddlog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StepperExample(title: 'Flutter Demo Home Page'),
    );
  }
}

class StepperExample extends StatefulWidget {
  StepperExample({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _StepperExample createState() => _StepperExample();
}

class _StepperExample extends State<StepperExample> {
  int groupValue = 0;

  StepperType _type = StepperType.horizontal;

  List<Tuple2> tuples = [
    Tuple2(
      Icons.directions_bike,
      StepState.indexed,
    ),
    Tuple2(
      Icons.directions_bus,
      StepState.editing,
    ),
    Tuple2(
      Icons.directions_railway,
      StepState.complete,
    ),
    Tuple2(Icons.directions_boat, StepState.disabled, ),
    Tuple2(Icons.directions_boat, StepState.disabled, ),
    // Tuple2(Icons.directions_car, StepState.error, ),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xFF652D8F),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0.5, -0.05),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
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
      body: buildStepperCustom(context),
      // body: buildStepperCustom(context),
    );
  }



  void go(int index) {
    if (index == -1 && _index <= 0) {
      ddlog("it's first Step!");
      return;
    }

    if (index == 1 && _index >= tuples.length - 1) {
      ddlog("it's last Step!");
      return;
    }

    setState(() {
      _index += index;
    });
  }


  Widget buildStepperCustom(BuildContext context) {
    return EnhanceStepper(
        // stepIconSize: 60,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: tuples
            .map((e) => EnhanceStep(
                  // icon: Icon(
                  //   e.item1,
                  //   // Icons.add,
                  //   color: Colors.blue,
                  //   size: 60,
                  // ),
                  state: StepState.values[tuples.indexOf(e)],
                  isActive: _index == tuples.indexOf(e),
                  title: Text("step ${tuples.indexOf(e)}"),
                  subtitle: Text(
                    "${e.item2.toString().split(".").last}",
                  ),
                  content: Text("Content for Step ${tuples.indexOf(e)}"),
                ))
            .toList(),
        onStepCancel: () {
          go(-1);
        },
        onStepContinue: () {
          go(1);
        },
        onStepTapped: (index) {
          ddlog(index);
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text("Next"),
              ),
              SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: details.onStepCancel,
                child: Text("Back"),
              ),
            ],
          );
        });
  }
}