import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Recover.dart';
import 'package:get/get.dart';
import '../ComponentsLogin/constants.dart';
import '../ComponentsLogin/controller/simple_ui_controller.dart';

class changePasswordScreen extends StatefulWidget {
  final int? id;
  const changePasswordScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<changePasswordScreen> createState() => _changePasswordScreen();
}

class _changePasswordScreen extends State<changePasswordScreen> {
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController cpassword2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var validation;
  @override
  void dispose() {
    cpasswordController.dispose();
    cpassword2Controller.dispose();
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

  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
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
          padding: const EdgeInsets.only(left: 20.0),
          child: Text('Cambiar contraseña', style: TextStyle(fontSize: 20.0)),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: kTextFormFieldStyle(),
                  controller: cpasswordController,
                  obscureText: simpleUIController.isObscure.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: IconButton(
                      icon: Icon(
                        simpleUIController.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        simpleUIController.isObscureActive();
                      },
                    ),
                    hintText: 'Contraseña',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  style: kTextFormFieldStyle(),
                  controller: cpassword2Controller,
                  obscureText: simpleUIController.isObscure.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: IconButton(
                      icon: Icon(
                        simpleUIController.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        simpleUIController.isObscureActive();
                      },
                    ),
                    hintText: 'Repetir contraseña',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Rellene este campo';
                    } else if (value.length < 7) {
                      return 'Ingrese como mínimo 6 carácteres';
                    } else if (value.length > 13) {
                      return 'Ingrese como máximo 13 carácteres';
                    } else if (value != validation) {
                      return 'Las contraseñas no coinciden.';
                    }
                    return null;
                  },
                ),
                Text(
                  'Comprobaremos el código ingresado.',
                  style: kLoginTermsAndPrivacyStyle(size),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// SignUp Button
                codeVerificationButton(theme),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // SignUp Button
  Widget codeVerificationButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 115.0, left: 20, right: 20),
      child: SizedBox(
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
            if (_formKey.currentState!.validate()) {
              changePassword(widget.id, cpassword2Controller.text, context);
            }
          },
          child: const Text('Aceptar'),
        ),
      ),
    );
  }
}
