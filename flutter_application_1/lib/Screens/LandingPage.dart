import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
          title:Image.asset('assets/images/AHM-Fondo-Nombre.png',width: 185,height: 650,),
          backgroundColor: Color.fromRGBO(101,45,143,1),
        ),
        body: ListView(
      children: <Widget>[
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),side:  BorderSide(color: Colors.black,width: 3),),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                children: <Widget>[
                    Text('\n'),
                    Icon(Icons.airplane_ticket),
                  ListTile(
                    title: Text('                                                 BÁSICO\n              ______________________________________________'),
                    subtitle: Text('                                                   Hotel 3 estrellas\n      ______________________________________________________________\n                                        Desayuno | Almuerzo | Cena\n      ______________________________________________________________\n                                 Realización de actividades básicas\n      ______________________________________________________________\n                                           Atención al dormitorio\n '),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),side:  BorderSide(color: Colors.black,width: 3),),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                   Text('\n'),
                    Icon(Icons.downhill_skiing ),
                  ListTile(
                    title: Text('                                                   PLUS\n              ______________________________________________'),
                    subtitle: Text('                                                   Hotel 4 estrellas\n      ______________________________________________________________\n                                        Desayuno | Almuerzo | Cena\n      ______________________________________________________________\n                                 Realización de actividades Turísticas\n      ______________________________________________________________\n                                           Atención al dormitorio\n      ______________________________________________________________\n                              Acceso a piscina | Uso del gimnasio \n      ______________________________________________________________\n                                                          Surfear\n '),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin:EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),side:  BorderSide(color: Colors.black,width: 3),),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('\n'),
                    Icon(Icons.diamond),
                  ListTile(
                    title: Text('                                                    PRO\n              ______________________________________________'),
                    subtitle: Text('                                                   Hotel 5 estrellas\n      ______________________________________________________________\n                                        Desayuno | Almuerzo | Cena\n      ______________________________________________________________\n                                 Realización de actividades Turísticas\n      ______________________________________________________________\n                                           Atención al dormitorio\n      ______________________________________________________________\n                     Acceso a piscina | Uso del gimnasio | Uso del Spa\n      ______________________________________________________________\n                                                          Surfear\n '),
                  ),
                ],
              ),
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

  