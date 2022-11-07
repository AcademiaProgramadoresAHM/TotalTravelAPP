import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/UsersViewModel.dart';
import 'package:flutter_application_1/Models/customPackageViewModel.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/navigation_home_screen.dart';
import '../ComponentsLogin/constants.dart';
import '../ComponentsLogin/controller/simple_ui_controller.dart';

class SuccessCustomPackage extends StatefulWidget {
  final UserLoggedModel? userloggeddata;
  final customPackageViewModel customPackage;
  const SuccessCustomPackage(this.userloggeddata,this.customPackage, {Key? key})
      : super(key: key);

  @override
  State<SuccessCustomPackage> createState() =>
      _SuccessCustomPackage();
}

class _SuccessCustomPackage extends State<SuccessCustomPackage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Get.put(SimpleUIController());

    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildSmallScreen(size, simpleUIController);
            } else {
              return _buildSmallScreen(size, simpleUIController);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          '\n\n\n\n\n\n',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset('assets/images/AHM-Fondo-Nombre-inverso-3.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  child: RichText(
                    text: TextSpan(
                      text: 'Su reservacion a sido procesada con éxito!',
                      style: kHaveAnAccountStyle(size),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),

                /// Login Button
                _loginButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget _loginButton() {
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
  /*        print("UsuarioID: " + widget.customPackage.usua_ID.toString());
    print("HoteID: " + widget.customPackage.hote_ID.toString());
    print("FechaEntrada: " + widget.customPackage.reHo_FechaEntrada.toString());
    print("FechaSalida: " + widget.customPackage.reHo_FechaSalida.toString());
    print("Noches: " + widget.customPackage.hote_numNoches.toString());
    print("Personas: " + widget.customPackage.hote_numeroPersonas.toString());
    print("HabitacionID: " + widget.customPackage.habi_ID.toString());
    print("Cantidad Habitaciones: " + widget.customPackage.habi_Cantidad.toString());
    print("Total: " + widget.customPackage.reHo_PrecioTotal.toString());

    print("ActividadesExtra: " + widget.customPackage.actividadesExtra.toString());
    print("Restaurantes: " + widget.customPackage.Restaurant.toString());

    print("TransportePartner: " + widget.customPackage.partner.toString());
    print("CiudadSalidaID: " + widget.customPackage.ciudadSalida_ID.toString());
    print("CiudadLlegadaID: " + widget.customPackage.ciudadLlegada_ID.toString());
    print("HoraSalida: " + widget.customPackage.horaSalida.toString());
    print("Personas: " + widget.customPackage.tprt_cantidadPersonas.toString());
    print("Total: " + widget.customPackage.tprt_Total.toString());

    print("TotalPaquete: " + widget.customPackage.PackageTotal.toString());
    print("TipoPago: " + widget.customPackage.tipoPago.toString());
    print("CantidadPagos: " + widget.customPackage.CantidadPagos.toString());*/

  
    print(widget.customPackage.toJson().toString());
    print(widget.customPackage.actividadesExtras.toString());
    print(widget.customPackage.restaurantes.toString());
    print(widget.customPackage.reservacionTransportes.toString());
      
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationHomeScreen(
                  MyHomePage(widget.userloggeddata), widget.userloggeddata),
            ),
          );
        },
        child: const Text('Aceptar'),
      ),
    );
  }
}
