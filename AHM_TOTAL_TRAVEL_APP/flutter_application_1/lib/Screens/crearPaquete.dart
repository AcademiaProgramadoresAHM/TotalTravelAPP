import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/AppWidget.dart';
import 'package:flutter_application_1/utils/prueba2/T2Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../ComponentsLogin/constants.dart';
import '../main.dart';


final List<String> items = [
  'A_Item1',
  'A_Item2',
  'A_Item3',
  'A_Item4',
  'B_Item1',
  'B_Item2',
  'B_Item3',
  'B_Item4',
];

class createPackage extends StatefulWidget {
  const createPackage({Key? key}) : super(key: key);

  @override
  _createPackage createState() => _createPackage();
}

class _createPackage extends State<createPackage> {
  String? selectedValue;
final TextEditingController textEditingController = TextEditingController();
  String? dropDownValue;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
      body: SafeArea(
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
                    alignment: AlignmentDirectional(0.05, 0),
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
                      height: 200,
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
                            alignment: AlignmentDirectional(0, 0.06),
                            child:   Container(
                              height: 65,
                              decoration: BoxDecoration(color: Colors.white),
                              child: TextFormField(
                                      style: kTextFormFieldStyle(),
                                      controller: dateOfBirthController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.calendar_today),
                                        hintText: 'Fecha',
                                        border: InputBorder.none
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1901),
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(pickedDate);
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(formattedDate);
                                          setState(() {
                                            dateOfBirthController.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Fecha no seleccionada");
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor ingrese una fecha';
                                        }
                                        return null;
                                      },
                                    ),
                            ),
                          ),
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
                                onPressed: () { },
                                child: Text('Buscar'),
                              ),
                            
                            ),
                          ),
                       Container(
                          height: 65,
                        decoration: BoxDecoration(color: Colors.white),
                         child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextFormField(
                                      style: kTextFormFieldStyle(),
                                      controller: dateOfBirthController,
                                      decoration: const InputDecoration(
                                      
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.calendar_today),
                                        hintText: 'Destino',
                                        
                                      ),
                                    ),
                                  ),
                                  items: items
                                          .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )).toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonHeight: 70,
                                  buttonWidth: 400,
                                  itemHeight: 40,
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
                ],
              ),
              LinearPercentIndicator(
                percent: 0.5,
                width: 392,
                lineHeight: 24,
                animation: true,
                progressColor: Color(0xFFFFC36D),
                backgroundColor: Color(0xFFF1F4F8),
                center: Text(
                  '50%',
                  style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF652D8F),
                      ),
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}