import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/ReserDetalles.dart';


class PersonaliScreen extends StatefulWidget {
  @override
  _PersonaliScreenState createState() => _PersonaliScreenState();
}

class _PersonaliScreenState extends State<PersonaliScreen> {
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
          title: Text('           Reservaciones Hechas'),
          backgroundColor: Color.fromRGBO(101,45,143,1),
        ),
        body: ListView(
        children: <Widget>[
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => print("ciao"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                                  'assets/images/Honduras.png',
                                )
                    ),
                    ListTile(                   
                      title: Text('Honduras'),
                      subtitle: Text('Hotel: Pepitos Intercontinental \nReservado el: 22/09/22'),                                         
                      trailing: Text('L.5900.00', style: TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                      TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { 
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Personali2Screen()),
                          );
                      },    
                      child: Text('Ver Detalles'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => print("ciao"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                                  'assets/images/Honduras.png',
                                )
                    ),
                    ListTile(                   
                      title: Text('Honduras'),
                      subtitle: Text('Hotel: Pepitos Intercontinental \nReservado el: 22/09/22'),
                      trailing: Text('L.5900.00', style: TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                      TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { 
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Personali2Screen()),
                          );
                      },    
                      child: Text('Ver Detalles'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => print("ciao"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                                  'assets/images/Honduras.png',
                                )
                    ),
                    ListTile(                   
                      title: Text('Honduras'),
                      subtitle: Text('Hotel: Pepitos Intercontinental \nReservado el: 22/09/22'),
                      trailing: Text('L.5900.00', style: TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                      TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { 
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Personali2Screen()),
                          );
                      },    
                      child: Text('Ver Detalles'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => print("ciao"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                                  'assets/images/Honduras.png',
                                )
                    ),
                    ListTile(                   
                      title: Text('Honduras'),
                      subtitle: Text('Hotel: Pepitos Intercontinental \nReservado el: 22/09/22'),
                      trailing: Text('L.5900.00', style: TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                      TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { 
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Personali2Screen()),
                          );
                      },    
                      child: Text('Ver Detalles'),
                    )
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

  