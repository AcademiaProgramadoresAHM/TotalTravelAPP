import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_application_1/Screens/Login.dart';
import 'package:flutter_application_1/Screens/signUp_view.dart';



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
        Text('\n'),
        CarouselSlider(
              options: CarouselOptions(
                height: 650.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Color.fromRGBO(101,45,143,1),
                        child: card,
                      ),
                    );
                  }
                );
              }).toList(),
            ),
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: map<Widget>(cardList, (index, url) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Color.fromRGBO(101,45,143,1) : Colors.grey,
       ),
     );
   }),
 ), 
   Padding( padding:EdgeInsets.all(16.0), child: SizedBox(
      width: double.infinity,
      height: 45,
     
      child: ElevatedButton(
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(Colors.red),
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(101,45,143,1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
          /* Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
             ... Navigate To your Home Page
          }*/
        },
        child: const Text('Login'),
      ),
    ),),
   Padding( padding:EdgeInsets.all(16.0), child: SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(Colors.red),
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 106, 115)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpView()),
          );
          /* Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
             ... Navigate To your Home Page
          }*/
        },
        child: const Text('Registrarse'),
      ),
    ),)

     
    
    
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

Widget _Card1(){

  return Card(
     child:  Container(
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
                    title: Text('BÁSICO\n              _____________________________________________',textAlign: TextAlign.center,),
                    subtitle: Text('\n\nHotel 3 estrellas\n\n___________________________________________________\n\nDesayuno | Almuerzo | Cena\n\n___________________________________________________\n\nRealización de actividades básicas\n\n___________________________________________________\n\nAtención al dormitorio\n ',textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
}
Widget _Card2(){

  return Card(
     child:  Container(
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
                    title: Text('PLUS\n              ___________________________________________',textAlign: TextAlign.center,),
                    subtitle: Text('\n\nHotel 4 estrellas\n\n___________________________________________________\n\nDesayuno | Almuerzo | Cena\n\n___________________________________________________\n\nRealización de actividades Turísticas\n\n___________________________________________________\n\nAtención al dormitorio\n\n___________________________________________________\n\nAcceso a piscina | Uso del gimnasio\n\n___________________________________________________\n\nSurfear\n',textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
}
Widget _Card3(){

  return Card(
     child:  Container(
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
                    title: Text('PRO\n              ___________________________________________',textAlign: TextAlign.center,),
                    subtitle: Text('\n\nHotel 5 estrellas\n\n___________________________________________________\n\nDesayuno | Almuerzo | Cena\n\n___________________________________________________\n\nRealización de actividades Turísticas\n\n___________________________________________________\n\nAtención al dormitorio\n\n___________________________________________________\n\nAcceso a piscina | Uso del gimnasio | Uso del Spa\n\n___________________________________________________\n\nSurfear\n',textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
}

int _currentIndex=0;

List cardList=[
    _Card1(),
    _Card2(),
    _Card3()

  ];
List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

