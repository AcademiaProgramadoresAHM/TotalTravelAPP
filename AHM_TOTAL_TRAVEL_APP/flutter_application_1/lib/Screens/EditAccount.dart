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
import 'package:flutter_application_1/SuccessOrErrorScreens/SuccessfullyEditUser.dart';
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
  final Map<int?, String> CountriesDictionary;
  final Map<String, dynamic> userData;
  const EditAccount(
      this.userloggeddata, this.CountriesDictionary, this.userData,
      {Key? key})
      : super(key: key);
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  int? suburbValue, CountryValue, CityValue;
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
  String? name, surname, email, phone, dni, street, avenue;

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
  var validation;
  String? _sexo, choice;

  final lastDate = DateTime.now();
  final firstDate = DateTime.utc(1900, 1, 1);

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

  int? CountriesDropDownValue;
  int? CitiesDropDownValue;
  int? SuburbsDropDownValue;

  //bool _isVisible1 = false;
  // bool _isVisible2 = false;
  // bool _isVisible3 = false;
  bool _isVisibleCountries = false;
  bool _isVisibleCities = false;
  bool _isVisibleSuburbs = false;
  String defaultDetalles = '';
  String? adressId;
  CiudadesViewModel? planDetalles;
  AdressesViewModel? adressData;

  void showToast2(bool result2) {
    setState(() {
      _isVisibleCountries = result2;
    });
  }

  void showToast3(bool result3) {
    setState(() {
      _isVisibleCities = result3;
    });
  }

  void showToast4(bool result3) {
    setState(() {
      _isVisibleSuburbs = result3;
    });
  }

  Map<int?, String> CitiesDictionary = Map();
  Future<dynamic> GetCities(CountryId) async {
    List<dynamic> dataCities;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Cities/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      dataCities = Json.data;
      var data = dataCities.where((x) => x['paisID'] == CountryId).toList();
      // rellena diccionario de datos
      data.forEach((x) {
        CiudadesViewModel element = CiudadesViewModel.fromJson(x);
        var descripcion = element.Ciudad!;
        setState(() {
          CitiesDictionary[element.ID] = descripcion;
        });
      });
      return Json.data;
    } else {
      print("Error: " + respuesta.statusCode.toString());
    }
  }

  Map<int?, String> SuburbsDictionary = Map();

  Future<dynamic> GetSuburbs(CityId) async {
    List<dynamic> dataSuburbs;
    String url_list =
        "https://apitotaltravel.azurewebsites.net/API/Suburbs/List";
    var respuesta = await http.get(Uri.parse(url_list));
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> ServerResponse = jsonDecode(respuesta.body);
      var Json = DecoderAPI.fromJson(ServerResponse);
      dataSuburbs = Json.data;
      var data = dataSuburbs.where((x) => x['ciudadID'] == CityId).toList();
      // rellena diccionario de datos
      data.forEach((x) {
        SuburbsViewModel element = SuburbsViewModel.fromJson(x);
        var descripcion = element.Colonia!;
        setState(() {
          SuburbsDictionary[element.ID] = descripcion;
        });
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

    final url = Uri.parse(
        "https://apitotaltravel.azurewebsites.net/API/Address/Insert");
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
              phoneController.text,
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
      String Telefono,
      String adressId,
      BuildContext context) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    final uri = Uri.parse(
        "https://apitotaltravel.azurewebsites.net/API/Users/Update?id=" +
            widget.userloggeddata!.ID.toString());
    var map = new Map<String, dynamic>();
    map['usua_DNI'] = DNI;
    map['usua_Nombre'] = Nombre;
    map['usua_Apellido'] = Apellido;
    map['usua_Telefono'] = Telefono;
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
              builder: (context) => SuccessEditUser(widget.userloggeddata),
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

  Future<void> GetUserData(data) async {
    setState(() {
      _userData = data;
      name = _userData['nombre'];
      surname = _userData['apellido'];
      email = _userData['email'];
      phone = _userData['telefono'];
      dni = _userData['dni'];
      street = _userData['calle'];
      avenue = _userData['avenida'];
    });
  }

  @override
  void initState() {
    dateOfBirthController.text = ""; //set the initial value of text field

    // GetCities();
    // GetSuburbs();
    init();
    GetUserData(widget.userData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    // var splitFecha = _userData['fecha_Nacimiento'].toString().split('T');
    // print(splitFecha);

    // dateOfBirthController.text = splitFecha[0];
    //print(fecha);
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
                        // CircularProgressIndicator(
                        //   color: Color.fromARGB(255, 101, 45, 144)),
                        // SizedBox(
                        //   height: size.height * 0.03,
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 170.0, top: 10.0, bottom: 20.0),
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
                                  initialValue: name ?? '',

                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else {
                                      nameController.text = value;
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

                                  initialValue: surname ?? '',
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else {
                                      surnameController.text = value;
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
                                  initialValue: email ?? '',
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
                                      return 'Ingrese un correo válida';
                                    } else {
                                      emailController.text = value;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 155.0, top: 10.0, bottom: 20.0),
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

                                  initialValue: dni ?? '',
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else if (value.length < 13) {
                                      return 'Ingrese como mínimo 13 carácteres';
                                    } else if (value.length > 13) {
                                      return 'Ingrese como máximo 13 carácteres';
                                    } else {
                                      dniController.text = value;
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

                                  initialValue: phone ?? '',
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else if (value.length < 8) {
                                      return 'Ingrese un número telefonico válido';
                                    } else {
                                      phoneController.text = value;
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 250.0, top: 30.0, bottom: 20.0),
                                  child: Text('Dirección',
                                      style: TextStyle(fontSize: 16.0)),
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      width: 350,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          /*color: Colors.transparent*/),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Selecciona un pais',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      101, 45, 143, 1),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: widget.CountriesDictionary.keys
                                            .map((id) {
                                          return DropdownMenuItem(
                                              value: id,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(30, 0, 0, 0),
                                                child: Text(
                                                  widget.CountriesDictionary[id]
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    //color: Colors.black,
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                                        value: CountryValue,
                                        onChanged: (value) {
                                          setState(() {
                                            CountryValue = value as int?;
                                            CountriesDropDownValue = value;
                                            //CitiesDictionary = widget.CitiesDictionary;
                                            if (CityValue != null) {
                                              CityValue = null;
                                            }
                                            CitiesDictionary.clear();
                                            SuburbsDictionary.clear();
                                            GetCities(CountriesDropDownValue);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_double_arrow_down,
                                        ),
                                        iconSize: 20,
                                        iconEnabledColor:
                                            Color.fromRGBO(101, 45, 143, 1),
                                        iconDisabledColor: Colors.grey,
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white,
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 150,
                                        dropdownWidth: 350,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(10),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                      )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 200.0, top: 0, bottom: 10.0),
                                  child: Visibility(
                                    visible: _isVisibleCountries,
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
                                      width: 350,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Selecciona una ciudad',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      101, 45, 143, 1),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: CitiesDictionary.keys.map((id) {
                                          return DropdownMenuItem(
                                              value: id,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(30, 0, 0, 0),
                                                child: Text(
                                                  CitiesDictionary[id]
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                                        value: CityValue,
                                        onChanged: (value) {
                                          setState(() {
                                            CityValue = value as int?;
                                            CitiesDropDownValue = value;

                                            if (suburbValue != null) {
                                              suburbValue = null;
                                            }
                                            SuburbsDictionary.clear();
                                            GetSuburbs(CitiesDropDownValue);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_double_arrow_down,
                                        ),
                                        iconSize: 20,
                                        iconEnabledColor:
                                            Color.fromRGBO(101, 45, 143, 1),
                                        iconDisabledColor: Colors.grey,
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white,
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 150,
                                        dropdownWidth: 350,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(10),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                      )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 200.0, top: 0, bottom: 10.0),
                                  child: Visibility(
                                    visible: _isVisibleCities,
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
                                      width: 350,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Selecciona una colonia',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      101, 45, 143, 1),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: SuburbsDictionary.keys.map((id) {
                                          return DropdownMenuItem(
                                              value: id,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(30, 0, 0, 0),
                                                child: Text(
                                                  SuburbsDictionary[id]
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                                        value: suburbValue,
                                        onChanged: (value) {
                                          setState(() {
                                            suburbValue = value as int?;
                                            SuburbsDropDownValue = value;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.keyboard_double_arrow_down,
                                        ),
                                        iconSize: 20,
                                        iconEnabledColor:
                                            Color.fromRGBO(101, 45, 143, 1),
                                        iconDisabledColor: Colors.grey,
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white,
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 150,
                                        dropdownWidth: 350,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(10),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                      )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 200.0, top: 0, bottom: 10.0),
                                  child: Visibility(
                                    visible: _isVisibleSuburbs,
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

                                  initialValue: street ?? '',
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else {
                                      calleController.text = value;
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

                                  initialValue: avenue ?? '',
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rellene este campo';
                                    } else {
                                      avenidaController.text = value;
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

          bool result;
          if (SuburbsDropDownValue == null ||
              CitiesDropDownValue == null ||
              CountriesDropDownValue == null) {
            /*
            if (_sexo == null) {
              result = true;
              showToast1(result);
            } else {
              result = false;
              showToast1(result);
            }*/

            if (CountriesDropDownValue == null) {
              result = true;
              showToast2(result);
            } else {
              result = false;
              showToast2(result);
            }

            if (CitiesDropDownValue == null) {
              result = true;
              showToast3(result);
            } else {
              result = false;
              showToast3(result);
            }

            if (SuburbsDropDownValue == null) {
              result = true;
              showToast4(result);
            } else {
              result = false;
              showToast4(result);
            }

            if (_formKey.currentState!.validate()) {}
          } else if (SuburbsDropDownValue != null &&
              CitiesDropDownValue != null &&
              CountriesDropDownValue != null) {
            result = false;
            showToast2(result);
            showToast3(result);
            showToast4(result);
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
