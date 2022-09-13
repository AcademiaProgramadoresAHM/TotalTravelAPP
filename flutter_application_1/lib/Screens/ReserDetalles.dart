import 'package:flutter_application_1/Screens/Personalizados.dart';
import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_Screen.dart';
import 'package:flutter_application_1/home_screen.dart';

import '../navigation_home_screen.dart';


class Personali2Screen extends StatefulWidget {
  @override
  _Personali2ScreenState createState() => _Personali2ScreenState();
}

class _Personali2ScreenState extends State<Personali2Screen> {
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
        appBar: AppBar
        (   
          leading: TextButton(
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
             onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonaliScreen()),
                  );
                },
              child: Icon(Icons.arrow_back_ios),
            ), 
                         
          title: Text('   Detalles de la Reservacion'),
          backgroundColor: Color.fromRGBO(101,45,143,1),
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
                    subtitle: Text('Cliente: Alvaro Reyes \nReservación hecha el : 22/09/22 \n\n'),
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
                    subtitle: Text('Interes Turistico: Honduras \nHotel de Hospedaje: Pepito´s Intercontinentals \nHabitación: A84 \nActividades Recretivas: Nadar con delfines, Sala de Juegos, Viaje en Lancha, Senderismo \n\n' ),
                    
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
                    leading: Icon(Icons.date_range),
                    title: Text('Fechas'),
                    subtitle: Text('Tiempo de Hospejade: 3 dias, 2 noches \nFecha de Ida: 23/09/22 \nFecha de Regreso: 26/09/22 \n\n'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[                    
                    ],
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
                  Text(" \n \n "),
                  const ListTile(
                    leading: Icon(Icons.info),
                    title: Text('** Información Adicional **'),
                    subtitle: Text(' Cualquier tipo de cambio, observación o error nos puedes contactar al número telefónico: +504 97979797 o al correo electronico: viajes123@gmail.com  \n\n'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                             
                    ],
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

  