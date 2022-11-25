import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ComponentsLogin/Recover.dart';
import 'package:flutter_application_1/Screens/codeVerification.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';

import 'package:get/get.dart';

import 'package:flutter_application_1/Screens/Login.dart';
import '../ComponentsLogin/constants.dart';
import '../ComponentsLogin/controller/simple_ui_controller.dart';

class recoverPassScreen extends StatefulWidget {
   final Map<int?, String> CountriesDictionary;
  const recoverPassScreen(this.CountriesDictionary, {Key? key}) : super(key: key);

  @override
  State<recoverPassScreen> createState() => _recoverPassViewState();
}

class _recoverPassViewState extends State<recoverPassScreen> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
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
          child: Text(
            'Recuperación de contraseña',
            style: TextStyle(fontSize: 20.0)
          ),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    hintText: 'Correo electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un correo electrónico';
                    } else if (!value.endsWith('@gmail.com')) {
                      return 'Ingrese una dirección válida';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Se enviará un código de verificación a su correo',
                  style: kLoginTermsAndPrivacyStyle(size),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// SignUp Button
                verificationButton(theme),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) => SignUpView(widget.CountriesDictionary)));
                    emailController.clear();
                    _formKey.currentState?.reset();

                    simpleUIController.isObscure.value = true;
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '¿No tienes cuenta?',
                      style: kHaveAnAccountStyle(size),
                      children: [
                        TextSpan(
                          text: " Regístrese",
                          style: kLoginOrSignUpTextStyle(
                            size,
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
      ],
    );
  }

  // SignUp Button
  Widget verificationButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 75.0),
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
            PostEmailVerification(emailController.text,context);
            }

          },
          child: const Text('Enviar código de verificación'),
        ),
      ),
    );
  }
}
