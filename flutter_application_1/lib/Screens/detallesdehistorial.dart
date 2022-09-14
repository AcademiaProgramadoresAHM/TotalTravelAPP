import 'package:flutter_application_1/Screens/historialcompras.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_Screen.dart';
import 'package:flutter_application_1/home_screen.dart';

import '../navigation_home_screen.dart';

class detalleshistorial extends StatefulWidget {
  @override
  _detalleshistorialState createState() => _detalleshistorialState();
}

class _detalleshistorialState extends State<detalleshistorial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Comprashistorial()),
              );
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          title: Text('   Detalles de compra'),
          backgroundColor: Color.fromRGBO(101, 45, 143, 1),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n "),
                    const ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text('Usuario'),
                      subtitle: Text(
                          'Cliente: Jose Matamodos \nReservación hecha el : 10/09/22 \n\n'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n"),
                    const ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Detalles'),
                      subtitle: Text(
                          'Viaje: Inglaterra \nHotel de Hospedaje: Hilton Prince \nHabitación: A84 \nTiempo de Hospedaje: 5 dias y 4 noches  \nActividades Reservadas: Nadar con delfines, Nadar con tiburones, Pesca, Caminata \n\n'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(" \n \n "),
                    const ListTile(
                      leading: Icon(Icons.info),
                      title: Text('** Información Adicional **'),
                      subtitle: Text(
                          ' Cualquier tipo de cambio, observación o error nos puedes contactar al número telefónico: +504 97979797 o al correo electronico: viajes123@gmail.com  \n\n'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
