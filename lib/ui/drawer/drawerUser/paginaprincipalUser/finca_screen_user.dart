import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../drawerAdmin/page_control/controlMonitoreo/cardImage.dart';

class FincaScreenUser extends StatelessWidget {
  static Widget create(BuildContext context) => FincaScreenUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/drawerUser');
          }),
        ),
        title: const Text(
          'Finca "La Victoria"',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Informacion(),
    );
  }
}

class Informacion extends StatefulWidget {
  const Informacion({super.key});

  @override
  State<Informacion> createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  @override
  Widget build(BuildContext context) {
    bool _isVisible = false;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Container(
            transform: Matrix4.translationValues(-100, 0, 0),
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.all((Radius.circular(30)))),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 90, 0),
              child: Text(
                'Reseña',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'La Finca "La Victoria", ubicada en la comunidad de Tesalia, ciudad de San Gabriel - Carchi. Esta finca dispone de "numero" hectareas el cual esta destinado para la producción tanto agricola como ganadera. Este espacio de tierra le pertenece al Sr."nombre". El presente le utiliza para cultivar una variedad de plantas. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),
          Container(
            transform: Matrix4.translationValues(100, 0, 0),
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.all((Radius.circular(30)))),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Text(
                '¿Como es la finca?',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // SizedBox(
          //   height: 30,
          // ),
          Container(
            height: 350.0,
            child: FadeIn(
              delay: Duration(seconds: 1),
              child: ListView(
                padding: const EdgeInsets.all(25.0),
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  CardImage(pathImage: "assets/img/mirador.jpg"),
                  CardImage(pathImage: "assets/img/cosecha_panoramica.jpg"),
                  CardImage(pathImage: "assets/img/cosecha.jpg"),
                  CardImage(pathImage: "assets/img/cosecha2.jpg"),
                  CardImage(pathImage: "assets/img/cosecha3.jpg")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            transform: Matrix4.translationValues(-70, 0, 0),
            height: 100,
            width: 350,
            decoration: const BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.all((Radius.circular(30)))),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(70, 10, 00, 0),
              child: Text(
                '¿Como actuará el sistema de monitoreo (SMT) en la finca?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'El sistema de monitoreo actuara en una zona especial limitada para poder realizar el analisis de la tierra del terreno. Con ello podemos estimar que planta es más adaptable cultivar. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          FadeInUp(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/img/zona_estudio.jpg',
              width: 300,
            ),
          )),
          SizedBox(
            height: 30,
          ),
          FadeInUp(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/img/plantas.jpg',
              width: 300,
            ),
          )),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
