// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/AdressesViewModel.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/Models/SuburbsViewModel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../hotel_booking/hotel_app_theme.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import '../ComponentsLogin/constants.dart';
import '../ComponentsLogin/controller/simple_ui_controller.dart';
import 'package:flutter_application_1/ComponentsLogin/Register.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  int? suburbValue;
   TextEditingController textSuburbsEditingController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController coloniaController = TextEditingController();
  TextEditingController calleController = TextEditingController();
  TextEditingController avenidaController = TextEditingController();
  TextEditingController direController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  
  final ScrollController _scrollController = ScrollController();
  
  List<ListModel> example = [
    ListModel(name: 'Cupertino Date Picker'),
    //ListModel(name: 'Cupertino Time Picker'),
    //ListModel(name: 'Cupertino Picker'),
  ];

  String? selectedValue;
  String? time;
  String? date;

  init() async {
    time = 'Please Select Time';
    date = 'Please select Date';
    selectedValue = 'Please select value';
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  final _formKey = GlobalKey<FormState>();
  var validation, _sexo;

  final lastDate = DateTime.now();
  final firstDate = DateTime.utc(1900, 1, 1);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: buildBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: buildBody(size, simpleUIController, theme),
    );
  }

//Dropdown cities

  int? CitiesDropDownValue;
  int? SuburbsDropDownValue;

  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;
  String defaultDetalles = '';
  String? adressId;
  CiudadesViewModel? planDetalles;
  AdressesViewModel? adressData;

  void showToast1(bool result) {
    setState(() {
      _isVisible1 = result;
    });
  }

  void showToast2(bool result2) {
    setState(() {
      _isVisible2 = result2;
    });
  }
   void showToast3(bool result3) {
    setState(() {
      _isVisible3 = result3;
    });
  }

  Map<int?, String> CitiesDictionary = Map();

  Future<dynamic> GetCities() async {
    var data;
    String url_list = "https://totaltravelapi.azurewebsites.net/API/Cities/List";
    final respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        CiudadesViewModel element = CiudadesViewModel.fromJson(x);
        var descripcion = element.Ciudad! + ", " + element.Pais.toString();
        CitiesDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Map<int?, String> SuburbsDictionary = Map();

  Future<dynamic> GetSuburbs() async {
    var data;
    String url_list = "https://totaltravelapi.azurewebsites.net/API/Suburbs/List";
    final respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      data = Json.data;
      // rellena diccionario de datos
      data.forEach((x) {
        SuburbsViewModel element = SuburbsViewModel.fromJson(x);

        var descripcion = element.Colonia!;
        SuburbsDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<void> PostAdress(int id, String calle, String avenida, BuildContext context) async {
    AdressesViewModel adressView = new AdressesViewModel();
    adressView.Colo_ID = id;
    adressView.Dire_Calle = calle;
    adressView.Dire_Avenida = avenida;
    adressView.Dire_UsuarioCreacion = 1;

    final url = Uri.parse("https://totaltravelapi.azurewebsites.net/API/Address/Insert");
    final headers = {
      "Content-type": "application/json",
      "Accept": "text/plain"
    };
    final json = jsonEncode(adressView);
    final response = await post(url, headers: headers, body: json);

    if (response.body != " ") {
      Map<String, dynamic> decoderMap = jsonDecode(response.body);
      var data = DecoderAPI.fromJson(decoderMap);
      if (data.data != null) {
        RequestStatus requestStatus = RequestStatus.fromJson(data.data);
        if (requestStatus.CodeStatus! >= 0) {
          adressId = requestStatus.CodeStatus.toString();
          PostRegister(
              dniController.text,
              nameController.text,
              lastnameController.text,
              emailController.text,
              dateOfBirthController.text,
              phoneController.text,
              _sexo,
              password2Controller.text,
              adressId!,
              context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    GetCities();
    GetSuburbs();
    init();
  }

  @override
  Widget buildBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: size.width > 600
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Image.asset(
                                'assets/images/AHM-Fondo-Nombre-inverso-3.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Crea tu cuenta',
                              style: kLoginSubtitleStyle(size),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 200.0, top: 10.0, bottom: 30.0),
                                    child: Text('Información general',
                                        style: TextStyle(fontSize: 16.0)),
                                  ),

                                  /// username
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Nombre',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: nameController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  // LastName
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Apellido',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: lastnameController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  /// Gmail
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_rounded),
                                      hintText: 'Correo Electrónico',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      } else if (!value
                                          .endsWith('@gmail.com')) {
                                        return 'Ingrese una dirección válida';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 190.0, top: 10.0, bottom: 20.0),
                                    child: Text('Información personal',
                                        style: TextStyle(fontSize: 16.0)),
                                  ),

                                  /// DNI
                                  ///
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.badge),
                                      hintText: 'DNI',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: dniController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      } else if (value.length < 13) {
                                        return 'Ingrese como mínimo 13 carácteres';
                                      } else if (value.length > 13) {
                                        return 'Ingrese como máximo 13 carácteres';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  //Birth
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    controller: dateOfBirthController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today),
                                      hintText: 'Fecha de Nacimiento',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
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
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  // Phone
                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      hintText: 'Teléfono',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: phoneController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      } else if (value.length < 8) {
                                        return 'Ingrese un número telefonico válido';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: 'M',
                                                groupValue: _sexo,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _sexo = value.toString();
                                                  });
                                                }),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Masculino ",
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: 18)),
                                                  WidgetSpan(
                                                    child: Icon(Icons.male,
                                                        size: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 'F',
                                                groupValue: _sexo,
                                                onChanged: (value) {
                                                  setState(() {
                                                    softWrap:
                                                    true;
                                                    _sexo = value.toString();
                                                  });
                                                }),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Femenino ",
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: 18)),
                                                  WidgetSpan(
                                                    child: Icon(Icons.female,
                                                        size: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 200.0, top: 10.0),
                                    child: Visibility(
                                      visible: _isVisible1,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Seleccione una opción ",
                                                style: TextStyle(
                                                    color: redColor,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 250.0, top: 30.0, bottom: 30.0),
                                    child: Text('Contraseña',
                                        style: TextStyle(fontSize: 16.0)),
                                  ),

                                  /// password
                                  Obx(
                                    () => TextFormField(
                                      style: kTextFormFieldStyle(),
                                      controller: passwordController,
                                      obscureText:
                                          simpleUIController.isObscure.value,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock_open),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            simpleUIController.isObscure.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            simpleUIController
                                                .isObscureActive();
                                          },
                                        ),
                                        hintText: 'Contraseña',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Rellene este campo';
                                        } else {
                                          validation = value;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                  ),
                                  Obx(
                                    () => TextFormField(
                                      style: kTextFormFieldStyle(),
                                      controller: password2Controller,
                                      obscureText:
                                          simpleUIController.isObscure.value,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock_open),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            simpleUIController.isObscure.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            simpleUIController
                                                .isObscureActive();
                                          },
                                        ),
                                        hintText: 'Repetir contraseña',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Rellene este campo';
                                        } else if (value.length < 7) {
                                          return 'Ingrese como mínimo 7 carácteres';
                                        } else if (value.length > 50) {
                                          return 'Ingrese como máximo 50 carácteres';
                                        } else if (value != validation) {
                                          return 'Las contraseñas no coinciden.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 260.0, top: 30.0),
                                    child: Text('Dirección',
                                        style: TextStyle(fontSize: 16.0)),
                                  ),
                                 

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 200.0, top: 10.0, bottom: 10.0),
                                    child: Visibility(
                                      visible: _isVisible2,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Seleccione una opción ",
                                                style: TextStyle(
                                                    color: redColor,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),

                                 Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0),
                                    child: 
                                    Container(
                          height: 65,
                        decoration: BoxDecoration(color: Colors.transparent),
                         child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextFormField(
                                      style: kTextFormFieldStyle(),
                                      decoration: const InputDecoration(
                                      
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.calendar_today),
                                        hintText: 'Colonia',
                                        
                                      ),
                                    ),
                                  ),
                                  items: SuburbsDictionary.keys.map((id) {
                                          return DropdownMenuItem(
                                            value: id,
                                            child: Text(SuburbsDictionary[id]
                                                .toString()),
                                          );
                                        }).toList(),
                                         value: suburbValue,
                                  onChanged: (value) {
                                    setState(() {
                                      suburbValue = value as int?;
                                       SuburbsDropDownValue = value;
                                    });
                                  },
                                  buttonHeight: 70,
                                  buttonWidth: 400,
                                  itemHeight: 40,
                                  dropdownMaxHeight: 200,
                                  searchController: textSuburbsEditingController,
                                  searchInnerWidget: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 4,
                                      right: 8,
                                      left: 10,
                                    ),
                                     child: TextFormField(
                                      controller: textSuburbsEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Busca un colonia',
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
                                    textSuburbsEditingController.clear();
                                  }
                                }
                      )),
                       )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 200.0, top: 0, bottom: 10.0),
                                    child: Visibility(
                                      visible: _isVisible3,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Seleccione una opción ",
                                                style: TextStyle(
                                                    color: redColor,
                                                    fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.edit_road),
                                      hintText: 'Calle',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: calleController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),

                                  TextFormField(
                                    style: kTextFormFieldStyle(),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.edit_road),
                                      hintText: 'Avenida',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),

                                    controller: avenidaController,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Rellene este campo';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: size.height * 0.06,
                                  ),

                                  /// SignUp Button
                                  signUpButton(theme),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),

                                  /// Navigate To Login Screen
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (ctx) => const Login()));
                                      nameController.clear();
                                      emailController.clear();
                                      passwordController.clear();
                                      _formKey.currentState?.reset();

                                      simpleUIController.isObscure.value = true;
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: '¿Ya tienes una cuenta?',
                                        style: kHaveAnAccountStyle(size),
                                        children: [
                                          TextSpan(
                                              text: " Inicia Sesión",
                                              style: kLoginOrSignUpTextStyle(
                                                  size)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dateBottomSheet(context) async {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    await showModalBottomSheet(
        context: context,
        builder: (BuildContext e) {
          return Container(
            height: 245,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cancelar',
                      ),
                      Text(
                        'Done',
                      )
                    ],
                  ).paddingOnly(top: 8, left: 8, right: 8, bottom: 8),
                ),
                Container(
                  height: 200,
                  child: CupertinoTheme(
                    data:
                        CupertinoThemeData(textTheme: CupertinoTextThemeData()),
                    child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      minimumDate: today,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (var dateTime) {
                        var dateFormat = new DateFormat('dd-MM-yyyy');
                        String formattedDate = dateFormat.format(dateTime);
                        print(formattedDate);
                        date = formattedDate;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromRGBO(101, 45, 143, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          // ... Navigate To your Home Page

          bool result, result2, result3;
          if (_sexo == null) {
            result = true;
            showToast1(result);
              if (SuburbsDropDownValue == null) {
              result3 = true;
              showToast3(result3);
               if (_formKey.currentState!.validate()) {}
              }
            
          } else if(SuburbsDropDownValue == null){
            result3 = true;
            showToast2(result3);
            result2 = false;
            showToast2(result2);
            if (_formKey.currentState!.validate()) {}
          }
           else if(_sexo != null && SuburbsDropDownValue != null ){
            result = false;
            showToast3(result);
            showToast2(result);
            showToast1(result);
            if (_formKey.currentState!.validate()) {
              PostAdress(SuburbsDropDownValue!, calleController.text, avenidaController.text, context);
            }
          }
        },
        child: const Text('Enviar'),
      ),
    );
  }
}


class ListModel {
  String? name;
  bool? isNew;
  Widget? widget;

  ListModel({this.name, this.widget, this.isNew});
}


