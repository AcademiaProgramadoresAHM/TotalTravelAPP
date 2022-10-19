// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account_screen.dart';
import 'package:flutter_application_1/ComponentsLogin/Decoder.dart';
//import 'package:flutter_application_1/ComponentsLogin/Edit.dart';
import 'package:flutter_application_1/ComponentsLogin/Register.dart';
import 'package:flutter_application_1/ComponentsLogin/constants.dart';
import 'package:flutter_application_1/ComponentsLogin/controller/simple_ui_controller.dart';
import 'package:flutter_application_1/Models/AdressesViewModel.dart';
import 'package:flutter_application_1/Models/RequestsViewModel.dart';
import 'package:flutter_application_1/Models/SuburbsViewModel.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/hotel_booking/hotel_app_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Models/CitiesViewModel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class EditAccount extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  const EditAccount(this.userloggeddata, {Key? key}) : super(key: key);
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  int? suburbValue;
  TextEditingController dniController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController coloniaController = TextEditingController();
  TextEditingController calleController = TextEditingController();
  TextEditingController avenidaController = TextEditingController();
  TextEditingController direController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController textSuburbsEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

  var name = "";

  @override
  void dispose() {
    dniController.dispose();
    nameController.dispose();
    surnameController.dispose();
    sexController.dispose();
    dateOfBirthController.dispose();
    phoneController.dispose();
    coloniaController.dispose();
    calleController.dispose();
    avenidaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

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
    var citiesData;
    String url_list = "https://totaltravel.somee.com/API/Cities/List";
    final respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      citiesData = Json.data;
      // rellena diccionario de datos
      citiesData.forEach((x) {
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
    var suburbsData;
    String url_list = "https://totaltravel.somee.com/API/Suburbs/List";
    final respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      suburbsData = Json.data;
      // rellena diccionario de datos
      suburbsData.forEach((x) {
        SuburbsViewModel element = SuburbsViewModel.fromJson(x);

        var descripcion = element.Colonia!;
        SuburbsDictionary[element.ID] = descripcion;
      });

      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Future<void> PostAdress(
      int id, String calle, String avenida, BuildContext context) async {
    AdressesViewModel adressView = new AdressesViewModel();
    adressView.Colo_ID = id;
    adressView.Dire_Calle = calle;
    adressView.Dire_Avenida = avenida;
    adressView.Dire_UsuarioCreacion = 1;

    final url = Uri.parse("https://totaltravel.somee.com/API/Address/Insert");
    final headers = {
      "Content-type": "application/json",
      "Accept": "text/plain"
    };
    final json = jsonEncode(adressView);
    final response = await http.post(url, headers: headers, body: json);

    if (response.body != " ") {
      Map<String, dynamic> decoderMap = jsonDecode(response.body);
      var data = DecoderAPI.fromJson(decoderMap);
      if (data.data != null) {
        RequestStatus requestStatus = RequestStatus.fromJson(data.data);
        if (requestStatus.CodeStatus! >= 0) {
          adressId = requestStatus.CodeStatus.toString();
          EditRegister(
              dniController.text,
              nameController.text,
              surnameController.text,
              emailController.text,
              dateOfBirthController.text,
              phoneController.text,
              _sexo,
              adressId!,
              context);
        }
      }
    }
  }

  Future<void> EditRegister(
      String DNI,
      String Nombre,
      String Apellido,
      String Email,
      String FechaNacimiento,
      String Telefono,
      String Sexo,
      String adressId,
      BuildContext context) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    final uri = Uri.parse("https://totaltravel.somee.com/API/Users/Update?id=" +
        widget.userloggeddata!.ID.toString());
    var map = new Map<String, dynamic>();
    map['usua_DNI'] = DNI;
    map['usua_Nombre'] = Nombre;
    map['usua_Apellido'] = Apellido;
    map['usua_FechaNaci'] = FechaNacimiento;
    map['usua_Telefono'] = Telefono;
    map['usua_Sexo'] = Sexo;
    map['usua_Email'] = Email;
    map['dire_ID'] = adressId;
    map['usua_esAdmin'] = "0";
    map['role_ID'] = "1";
    map['part_ID'] = "0";
    map['usua_UsuarioModifica'] = "1";
    map['file'] = "string";

    http.Response response = await http.put(
      uri,
      headers: headers,
      body: map,
    );

    if (response.body != " ") {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var data = DecoderAPI.fromJson(userMap);
      var status = RequestStatus.fromJson(data.data);
      if (status.CodeStatus! >= 0) {
        if (status.CodeStatus == 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: white,
            content: Text(
              textAlign: TextAlign.center,
              'El DNI ya está siendo utilizado.',
              style: TextStyle(color: redColor, fontSize: 16),
            ),
          ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: white,
          content: Text(
            textAlign: TextAlign.center,
            'Ha ocurrido un error.',
            style: TextStyle(color: redColor, fontSize: 16),
          ),
        ));
      }
    }
  }

  var _userData;

  Future<void> GetUserData() async {
    String url_list =
        "https://totaltravelapi.azurewebsites.net/API/Users/Find?id=" +
            widget.userloggeddata!.ID.toString();
    final headers = {
      "Content-type": "application/json",
      "Authorization": "bearer " + widget.userloggeddata!.Token!
    };
    final respuesta = await http.get(Uri.parse(url_list), headers: headers);
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(respuesta.body);
      var data = userMap['data'];
      setState(() {
        _userData = data;
      });
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  @override
  void initState() {
    dateOfBirthController.text = ""; //set the initial value of text field
    super.initState();
    GetCities();
    GetSuburbs();
    init();
    GetUserData();

    nameController.addListener(() {
      nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    dniController.text = _userData['dni'];
    nameController.text = _userData['nombre'];
    surnameController.text = _userData['apellido'];
    dateOfBirthController.text = _userData['fecha_Nacimiento'];
    phoneController.text = _userData['telefono'];
    sexController.text = _userData['sexo'];
    coloniaController.text = _userData['colonia'];
    calleController.text = _userData['calle'];
    avenidaController.text = _userData['avenida'];
    emailController.text = _userData['email'];

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('           Editar Cuenta'),
            backgroundColor: Color.fromRGBO(101, 45, 143, 1),
          ),
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
          child: _buildMainBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  Widget _buildMainBody(
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

                        /// username
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),

                                  controller: surnameController,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else if (!value.endsWith('@gmail.com')) {
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      height: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: TextFormField(
                                                  style: kTextFormFieldStyle(),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    prefixIcon: Icon(
                                                        Icons.calendar_today),
                                                    hintText: 'Colonia',
                                                  ),
                                                ),
                                              ),
                                              items: SuburbsDictionary.keys
                                                  .map((id) {
                                                return DropdownMenuItem(
                                                  value: id,
                                                  child: Text(
                                                      SuburbsDictionary[id]
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
                                              searchController:
                                                  textSuburbsEditingController,
                                              searchInnerWidget: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 4,
                                                  right: 8,
                                                  left: 10,
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      textSuburbsEditingController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText:
                                                        'Busca un destino',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              searchMatchFn:
                                                  (item, searchValue) {
                                                return (item.value
                                                    .toString()
                                                    .contains(searchValue));
                                              },
                                              onMenuStateChange: (isOpen) {
                                                if (!isOpen) {
                                                  textSuburbsEditingController
                                                      .clear();
                                                }
                                              })),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                registrarseButton(theme),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registrarseButton(ThemeData theme) {
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
          } else if (SuburbsDropDownValue == null) {
            result3 = true;
            showToast2(result3);
            result2 = false;
            showToast2(result2);
            if (_formKey.currentState!.validate()) {}
          } else if (_sexo != null && SuburbsDropDownValue != null) {
            result = false;
            showToast3(result);
            showToast2(result);
            showToast1(result);
            if (_formKey.currentState!.validate()) {
              PostAdress(SuburbsDropDownValue!, calleController.text,
                  avenidaController.text, context);
            }
          }
        },
        child: const Text('Editar'),
      ),
    );
  }
}
